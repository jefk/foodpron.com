
require 'net/http'
require 'uri'

class FoodpronClient

  def initialize(base_path)
    @base_path = base_path.start_with?('http://') ? base_path : "http://#{base_path}"
  end

  def post_image(url)
    uri = URI.parse("{base_path}/img-src")
    Net::HTTP.post_form(uri, :src => url)
  end

  def new_pron
    uri = URI.parse("{base_path}/pron")
    Net::HTTP.post_form(uri, "")
  end

end
