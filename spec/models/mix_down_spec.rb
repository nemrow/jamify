require 'spec_helper'

describe MixDown do
  before do
    @mix_down = MixDown.create
    @track = Track.create(:name => 'My Track')
  end

  it "should add track to a mix down" do
    track_count = @mix_down.tracks.count
    @mix_down.tracks << @track
    @mix_down.tracks.count.should == track_count + 1
  end

  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should have_many(:tracks) }
end
