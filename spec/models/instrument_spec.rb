require 'spec_helper'

describe Instrument do
  it { should have_many(:tracks) }
end
