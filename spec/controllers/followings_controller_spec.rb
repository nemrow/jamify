require 'spec_helper'

describe FollowingsController do
  context "when a post is sent to /api/users/:user_id/followings" do
    let (:user) { FactoryGirl.create(:user) }
    let (:user_2) { FactoryGirl.create(:user)}

    before do
      post :create, :user_id => user.id, :following_id => user_2.id
    end

    it "should add a following row" do
      UserFollowing.count.should == 1
    end

    it "should assign user_2 to user's followings" do
      user.followings.last.should == user_2
    end
  end
end
