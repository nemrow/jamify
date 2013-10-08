require 'spec_helper'

describe LikesController do
  before :each do
    @user = FactoryGirl.create(:user)
    @user_2 = FactoryGirl.create(:user)
    @user_3 = FactoryGirl.create(:user)
    @user_4 = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    @project_2 = FactoryGirl.create(:project)
    @mix_down = FactoryGirl.create(:mix_down)
    @mix_down.likes.create(:user_id => @user_2.id)
    @like = @project.likes.create(:user_id => @user.id)
    @project.likes.create(:user_id => @user_2.id)
    @project_2.likes.create(:user_id => @user_2.id)
  end

  context "when a get request is sent to /api/likes/type/:likeable_type/id/:likeable_id" do
    it "should return an array of users that like this Project" do
      get :index, :likeable_type => 'Project', :likeable_id => @project.id
      response_hash = JSON.parse(response.body)
      response_hash['users'].count.should == 2
    end

    it "should return an array of users that like this MixDown" do
      get :index, :likeable_type => 'MixDown', :likeable_id => @mix_down.id
      response_hash = JSON.parse(response.body)
      response_hash['users'].count.should == 1
    end
  end

  context "when a get request is sent to /api/likes/users/:user_sc_id/type/:likeable_type" do
    it "should return an array of Projects this user likes" do
      get :index, :user_sc_id => @user_2.sc_id, :likeable_type => 'Project'
      response_hash = JSON.parse(response.body)
      response_hash['objects'].count.should == 2
    end

    it "should return an array of MixDowns this user likes" do
      get :index, :user_sc_id => @user_2.sc_id, :likeable_type => 'MixDown'
      response_hash = JSON.parse(response.body)
      response_hash['objects'].count.should == 1
    end
  end

  context "when a post request is sent to /api/likes/type/:likeable_type/id/:likeable_id" do
    before :each do
      @mix_down_2 = FactoryGirl.create(:mix_down)
      @project_3 = FactoryGirl.create(:project)
    end

    it "should add a like to this Project" do
      post :create, :likeable_type => 'Project', :likeable_id => @project_3.id, :user_sc_id => @user.sc_id
      @project_3.likes.count.should == 1
    end

    it "should add a like to this MixDown" do
      post :create, :likeable_type => 'MixDown', :likeable_id => @mix_down_2.id, :user_sc_id => @user.sc_id
      @mix_down_2.likes.count.should == 1
    end
  end

  context "when a delete request is sent to /api/likes/id/:like_id" do
    before :each do
      @project_4 = FactoryGirl.create(:project)
      @likes_2 = @project_4.likes.create(:user_id => @user.id)
    end

    it "should delete entry of that like" do
      @project_4.likes.count.should == 1
      delete :destroy, :like_id => @likes_2.id
      @project_4.likes.count.should == 0
    end
  end
end
