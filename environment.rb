
require 'sequel'
require 'yaml'

require 'sinatra/reloader' if development?

DB = Sequel.sqlite 'db/foodpron.db'

Dir["#{settings.root}/models/**/*.rb"].each {|f| require f}
