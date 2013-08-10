require 'spec_helper'

describe User do
  before do
    @user = User.create(:first_name => 'Jordan', :last_name => 'Nemrow', :email => 'nemrowj@gmail.com', :sc_id => 12345)
  end

  it "should create a user" do
    @user.first_name.should == 'Jordan'
  end

  it { should have_many(:followings) }
  it { should have_many(:tracks) }
end
