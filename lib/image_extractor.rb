
require 'nokogiri'
require 'uri'
require 'net/http'

class ImageExtractor

  def self.largest_image(url)
    html_src = fetch(url).body
    doc = Nokogiri::HTML html_src
    imgs = doc.css('img').map{ |node| node.attribute('src').to_s }
    imgs.sort_by{ |url| content_length(url) }.last
  end

  def self.content_length(url)
    fetch(url, :head => true).content_length
  end

  def self.fetch(uri_str, options = {})
    limit = options[:limit] || 10
    raise "HTTP redirect too deep" if limit == 0

    url = URI.parse(uri_str)
    req = options[:head] ? Net::HTTP::Head.new(url.path) : Net::HTTP::Get.new(url.path)
    response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    case response
    when Net::HTTPSuccess
      response
    when Net::HTTPRedirection
      fetch(response['location'], :limit => limit -1, :head => options[:head])
    else
      response.error!
    end
  end

end
