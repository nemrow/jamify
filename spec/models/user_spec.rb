require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "should create a user" do
    @user.first_name.should == User.last.first_name
  end

  it { should have_many(:followings) }
  it { should have_many(:tracks) }
  it { should have_many(:master_tracks) }
  it { should have_many(:projects) }
  it { should have_many(:mix_downs) }
end
