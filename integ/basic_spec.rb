
require 'spec_helper'

describe :foodpron do
  before :all do
    @foodpron = FoodpronClient.new 'localhost:4567'
  end

  it "posts some images and picks prons!" do
    3.times do
      res = @foodpron.post_image('a')
      res.code.should == 201
    end

    res = @foodpron.post_image('b')
    res.code.should == 201

    res = @foodpron.new_pron
    res.code.should == 201
  end

end
