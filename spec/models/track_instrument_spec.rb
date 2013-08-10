require 'spec_helper'

describe TrackInstrument do
  it { should belong_to(:track) }
  it { should belong_to(:instrument) }
end
