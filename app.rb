
require 'sinatra'
require './environment'

get '/' do
  src = Image.pron || 'img/default.jpg'
  haml :index, locals: { :src => src }
end

post '/pron' do
  # set a new image
  src = Image.freshest
  if src.nil?
    status 204
    return
  end

  status 201
  Image.make_pron(src)
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
  Image.top_ten.map do |src, score|
    score = "%.2f" % score
    "#{score} - #{src}"
  end.join("<br>")
end

get '/style.css' do
  sass :style
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
