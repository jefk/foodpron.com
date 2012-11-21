
require 'spec_helper'

describe ImageExtractor do

  it "largest_image" do
    url = 'http://instagram.com/p/SRrbctzaov/'
    ImageExtractor.largest_image(url).should ==
      'http://distilleryimage3.instagram.com/268b0124338a11e29df022000a1fb07c_7.jpg'
  end

end
