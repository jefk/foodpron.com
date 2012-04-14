
require 'sinatra'
require './environment'

get '/' do
  Pron.current.image.src
end

post '/pron' do
  # set a new image
  img = Image.freshest
  if img.nil?
    status 204
    return
  end

  status 201
  pron = Pron.create
  img.pron_id = pron.id
  img.save
  ""
end

post '/img-src' do
  # increment the score of an image
  src = json_body['src']
  if src.nil? || src.empty?
    status 400
    Yajl.dump :errors => ":src cannot be blank"
  end

  status 201
  Image.increment src
end

post '/img-src/decay' do
  "nyi"
end

get '/scores' do
  Image.order(:score.desc).limit(20).map do |img|
    "#{img.score} - #{img.src}"
  end.join("<br>")
end

def json_body
  request.body.rewind # in case it has already been read
  Yajl.load request.body.read
end
