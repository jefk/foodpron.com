
require 'yaml'
require 'yajl'
require 'redis'

require 'sinatra/reloader' if development?

Dir["#{settings.root}/models/**/*.rb"].each {|f| require f}
