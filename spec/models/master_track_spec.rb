require 'spec_helper'

describe MasterTrack do
  let (:master_track) { FactoryGirl.create(:master_track) }

  it "should create a master_track" do 
    master_track.name.should == MasterTrack.last.name
  end

  it { should belong_to(:user) }
  it { should belong_to(:project) }
end
