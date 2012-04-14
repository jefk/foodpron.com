
require 'sinatra'
require './environment'

get '/' do
  "foodpr0n"
end

post '/pron' do
  # set a new image
  "nyi"
end

post '/img-src' do
  "nyi"
end

post '/img-src/decay' do
  "nyi"
end

get '/scores' do
  ImageSource.order(:score.desc).limit(20).map(:img_src).join("<br>")
end
