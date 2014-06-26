require 'spec_helper'

describe FollowingsController do
  let (:user) { FactoryGirl.create(:user) }
  let (:user_2) { FactoryGirl.create(:user)}

  context "when a post is sent to /api/users/:user_id/followings" do
    before do
      post :create, :user_id => user.id, :following_id => user_2.id
      @response_hash = JSON.parse(response.body)
    end

    it "should add a following row" do
      UserFollowing.count.should == 1
    end

    it "should assign user_2 to user's followings" do
      user.followings.last.should == user_2
    end

    it "should respond wth {:response => true}" do
      @response_hash['response'].should == true
    end
  end

  context "retreiving users following info" do
    let (:user_3) { FactoryGirl.create(:user, :first_name => 'threegirl')}
    let (:user_4) { FactoryGirl.create(:user, :first_name => 'fourthgirl')}

    before do
      user.followings << user_3
      user.followings << user_4
      user_4.followings << user_3
    end

    context "when a get is sent to /api/users/:user_sc_id/follows" do
      before do
        get :follows, :user_sc_id => user.sc_id
        @response_hash = JSON.parse(response.body)
      end

      it "should return all users who follow this user" do
        @response_hash['users'].count.should == 2
      end
    end

    context "when a get is sent to /api/users/:user_sc_id/followed_by" do
      before do
        get :followed_by, :user_sc_id => user_3.sc_id
        @response_hash = JSON.parse(response.body)
      end

      it "should return all users who follow this user" do
        @response_hash['users'].count.should == 2
      end
    end
  end
end
