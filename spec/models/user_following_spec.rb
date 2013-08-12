require 'spec_helper'

describe UserFollowing do
  let (:user) { FactoryGirl.create(:user) }
  let (:user2) { FactoryGirl.create(:user) }

  it { should belong_to(:user) }
  it { should belong_to(:following) }

  it "should allow user to follow another user" do
    user.followings << user2
    user.followings.first.should == user2
  end
end
