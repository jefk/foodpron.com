
require 'sinatra'
require './environment'

get '/' do
  Pron.current.image_source.src
end

post '/pron' do
  # set a new image
  unseen_imgs = Image.filter(:pron => nil)
  if unseen_imgs.empty?
    status 204
    return
  end

  Pron.create :image_id => unseen_imgs.max(:score).id
end

post '/img-src' do
  "nyi"
end

post '/img-src/decay' do
  "nyi"
end

get '/scores' do
  ImageSource.order(:score.desc).limit(20).map do |img|
    "#{img.score} - #{img.src}"
  end.join("<br>")
end
