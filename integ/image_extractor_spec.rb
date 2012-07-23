
require 'spec_helper'

describe ImageExtractor do

  it "largest_image" do
    url = 'http://oishidiah.tumblr.com/post/27021433563/post-work-out-meal-hawaiian-bbq-chicken'
    ImageExtractor.largest_image(url).should == 'http://25.media.tumblr.com/tumblr_m70zu1I8Gl1qe93ffo1_500.jpg'
  end

end
