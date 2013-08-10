require 'spec_helper'

describe ProjectGenre do
  it { should belong_to(:genre) }
  it { should belong_to(:project) }
end
