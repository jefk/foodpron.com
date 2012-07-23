
require 'sinatra'
require './environment'

get '/' do
  current = Pron.current
  if current.nil?
    "no pron yet!"
  else
    current.image.src
  end
end

post '/pron' do
  # set a new image
  img = Image.freshest
  if img.nil?
    status 204
    return
  end

  status 201
  img.make_pron
  ""
end

post '/img-src' do
  # increment the score of an image
  src = json_body['src']
  if src.nil? || src.strip.empty?
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
    score = "%.2f" % img.score
    "#{score} - #{img.src}"
  end.join("<br>")
end

def json_body
  request.body.rewind # in case it has already been read
  Yajl.load request.body.read
end

before do
  logger.info "-" * 30
  logger.info "params    :    #{params}"
  logger.info "json_body :    #{json_body}"
end
