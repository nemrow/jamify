require 'spec_helper'

describe MasterTracksController do
  let (:user) { FactoryGirl.create(:user) }
  let (:project) { FactoryGirl.create(:project) }

  context "When a post is sent to /api/users/:user_id/master_tracks" do
    it "should create a master_track and set it to the project and the user" do
      project.master_track.should == nil
      user.master_tracks.count.should == 0
      post :create, :user_id => user.id, :project_id => project.id, :master_track => {:name => 'My Master Track', :sc_id => 12345}
      response.should be_ok
      response_hash = JSON.parse(response.body)
      response_hash['response'].should == true
      response_hash['master_track_id'].should be_a_kind_of(Fixnum)
    end
  end
end
