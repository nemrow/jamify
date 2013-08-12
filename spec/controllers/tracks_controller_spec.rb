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
end
