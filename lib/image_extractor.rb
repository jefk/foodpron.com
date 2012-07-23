
require 'nokogiri'
require 'uri'
require 'net/http'

class ImageExtractor

  def self.largest_image(url)
    html_src = Net::HTTP.get URI.parse(url)
    doc = Nokogiri::HTML html_src
    imgs = doc.css('img').map{ |node| node.attribute('src').to_s }
    imgs.sort_by{ |url| content_length(url) }.last
  end

  def self.content_length(url)
    fetch(url).content_length
  end

  def self.fetch(uri_str, limit = 10)
    raise "HTTP redirect too deep" if limit == 0

    url = URI.parse(uri_str)
    req = Net::HTTP::Head.new(url.path)
    response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    case response
    when Net::HTTPSuccess
      response
    when Net::HTTPRedirection
      fetch(response['location'], limit - 1)
    else
      response.error!
    end
  end

end
