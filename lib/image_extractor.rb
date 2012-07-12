
require 'nokogiri'
require 'uri'
require 'net/http'

class ImageExtractor

  def self.largest_image(url)
    html_src = Net::HTTP.get URI.parse(url)
    doc = Nokogiri::HTML html_src
    imgs = doc.css('img').map{ |node| node.attribute('src').to_s }
    
  end

end
