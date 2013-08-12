require 'spec_helper'

describe MasterTracksController do
  let (:user) { FactoryGirl.create(:user) }
  let (:project) { FactoryGirl.create(:project) }

  context "When a post is sent to /api/users/:user_id/master_tracks" do
    before do
      post :create, :user_id => user.id, :project_id => project.id, :master_track => {:name => 'My Master Track', :sc_id => 12345}
      @response_hash = JSON.parse(response.body)
    end

    it "should create a master_track" do
      response.should be_ok
      MasterTrack.count.should == 1
    end

    it "assign master_track to the project" do
      project.master_track.name.should == "My Master Track"
    end

    it "assign master_track to the user" do
      user.master_tracks.last.name.should == "My Master Track"
    end
  end
end
