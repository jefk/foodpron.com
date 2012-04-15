
require 'spec_helper'

describe TwitterRobot do
  before :each do
    @robot = TwitterRobot.new ''
  end

  it "gets all the urls" do
    s = "http://beginning http://middle tweet http://end"
    @robot.send(:extract_urls, s).should == [
      'http://beginning',
      'http://middle',
      'http://end',
    ]
  end

end
