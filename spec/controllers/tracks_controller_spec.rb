require 'spec_helper'

describe TracksController do
  let (:user) { FactoryGirl.create(:user) }
  let (:project) { FactoryGirl.create(:project) }

  context "When a post is sent to /api/projects/:project_id/tracks" do
    before do
      post :create, :project_id => project.id, :user_id => user.id, 
        :track => {:name => 'My MixDown', :sc_id => 45224}
      @response_hash = JSON.parse(response.body)
    end

    it "should respond with {:response => true, :track_id => id}" do
      @response_hash['response'].should == true
      @response_hash['track_id'].should be_a_kind_of(Fixnum)
    end

    it "should create a track" do
      @response_hash['response'].should == true
    end

    it "should assign track to user" do
      user.tracks.last.id.should == @response_hash['track_id']
    end

    it "should assign track to project" do
      project.tracks.last.id.should == @response_hash['track_id']
    end
  end

  context "When get is sent to /api/tracks/:track_sc_id" do
    before :each do 
      @track = FactoryGirl.create(:track)
    end
    it "should return the that specific track" do
      get :show, :track_sc_id => @track.sc_id
      response_hash = JSON.parse(response.body)
      response_hash['track']['id'].should == @track.id
    end
  end
end
