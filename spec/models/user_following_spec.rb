require 'spec_helper'

describe UserFollowing do
  before do
    @user1 = User.create(:first_name => 'Jordan', :last_name => 'Nemrow', :email => 'nemrowj@gmail.com', :sc_id => 12345)
    @user2 = User.create(:first_name => 'Barry', :last_name => 'Nemrow', :email => 'barry@gmail.com', :sc_id => 23456)

  end

  it { should belong_to(:user) }
  it { should belong_to(:following) }

  it "should allow user to follow another user" do 
    @user1.followings << @user2
    @user1.followings.first.should == @user2
  end
end
