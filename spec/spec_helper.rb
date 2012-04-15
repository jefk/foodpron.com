
dir = File.dirname __FILE__
Dir["#{dir}/../lib/**/*.rb"].each {|f| require f}
