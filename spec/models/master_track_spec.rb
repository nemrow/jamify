require 'spec_helper'

describe MasterTrack do
  before do
    @master_track = MasterTrack.create(:name => 'Master Track 1')
  end

  it "should create a master_track" do 
    @master_track.name.should == "Master Track 1"
  end
end
