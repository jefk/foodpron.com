
require 'spec_helper'

describe :foodpron do
  before :all do
    @foodpron = FoodpronClient.new 'localhost:4567'
  end

  it "posts some images and picks prons!" do
    rando = rand 99999
    3.times do
      res = @foodpron.post_image("#{rando} calrissian")
      res.code.should == 201
    end

    res = @foodpron.post_image("one point #{rand 99999}")
    res.code.should == 201

    res = @foodpron.new_pron
    res.code.should == 201
  end

end
