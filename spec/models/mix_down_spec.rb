require 'spec_helper'

describe MixDown do
  let (:mix_down) { FactoryGirl.create(:mix_down) }
  let (:track) { FactoryGirl.create(:track)}

  it "should add track to a mix down" do
    mix_down.tracks << track
    mix_down.tracks.count.should == 1
  end

  it "Shold return the list of instruments ordered by most recent first" do
    10.times do |index|
      i = Instrument.create(:name => "drum_#{index}")
      track.instruments << i
    end

    mix_down.tracks << track
    instruments = MixDown.get_all_instruments_in_mix_down(mix_down)

    instruments.first.name.should == "drum_9"
  end

  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should have_many(:tracks) }
  it { should have_many(:comments) }
end
