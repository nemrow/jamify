require 'spec_helper'

describe Track do

  before do
    @track = Track.create(:name => 'My Track')
    @instrument = Instrument.create(:name => 'Guitar')
  end

  it "should create a track" do 
    @track.name.should == 'My Track'
  end

  it "should add instrument to track" do 
    instrument_count = @track.instruments.count
    @track.instruments << @instrument
    @track.instruments.count.should == instrument_count + 1
  end
  
  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should have_many(:instruments) }
  it { should have_many(:mix_downs) }
end
