require 'spec_helper'

describe MixDown do
  let (:mix_down) { FactoryGirl.create(:mix_down) }
  let (:track) { FactoryGirl.create(:track)}

  it "should add track to a mix down" do
    mix_down.tracks << track
    mix_down.tracks.count.should == 1
  end

  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should have_many(:tracks) }
end
