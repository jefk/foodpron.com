
require 'httparty'
require 'yajl'

class FoodpronClient
  include HTTParty

  def initialize(base_path)
    self.class.base_uri base_path
  end

  def post_image(url)
    post "/img-src", :src => url
  end

  def new_pron
    post "/pron"
  end

  private

  def post(path, hash = {})
    self.class.post(path, :body => Yajl.dump(hash) )
  end
end
