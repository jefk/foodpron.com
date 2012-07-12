
require 'spec_helper'

describe ImageExtractor do

  it "largest_image" do
    url = 'http://oishidiah.tumblr.com/post/27021433563/post-work-out-meal-hawaiian-bbq-chicken'
    p ImageExtractor.largest_image(url)
  end

end
