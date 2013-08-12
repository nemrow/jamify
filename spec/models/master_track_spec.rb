require 'spec_helper'

describe MasterTrack do
  before do
    @master_track = FactoryGirl.create(:master_track)
  end

  it "should create a master_track" do 
    @master_track.name.should == MasterTrack.last.name
  end

  it { should belong_to(:user) }
  it { should belong_to(:project) }
end
