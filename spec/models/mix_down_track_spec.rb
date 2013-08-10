require 'spec_helper'

describe MixDownTrack do
  it { should belong_to(:mix_down) }
  it { should belong_to(:track) }
end
