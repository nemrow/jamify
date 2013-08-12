require 'spec_helper'

describe MixDownsController do
  let (:user) { FactoryGirl.create(:user) }
  let (:project) { FactoryGirl.create(:project) }
  let (:track_1) { FactoryGirl.create(:track) }
  let (:track_2) { FactoryGirl.create(:track) }
  let (:track_3) { FactoryGirl.create(:track) }

  context "when a post is sent to /api/projects/:project_id/mix_downs" do
    
    before do
      post :create, :project_id => project.id, :user_id => user.id, 
        :mix_down => {:name => 'My MixDown', :sc_id => 45224},
        :tracks => [track_1.id, track_2.id, track_3.id]
        @response_hash = JSON.parse(response.body)
    end

    it "should create a new mix_down" do
      response.should be_ok
      @response_hash['response'].should == true
    end

    it "should assign mix_down to user" do
      response.should be_ok
      project.mix_downs.count.should == 1
      user.mix_downs.last.id.should == @response_hash['mix_down_id']
    end

    it "should assign mix_down to project" do
      project.mix_downs.last.id.should == @response_hash['mix_down_id']
    end

    it "should assign each included track to the mix_down" do
      project.mix_downs.last.tracks.count.should == 3
    end
  end
end
