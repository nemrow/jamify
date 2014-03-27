require 'spec_helper'

describe CommentsController do
  before(:each) do
    @project = FactoryGirl.create(:project)
    @master_track = FactoryGirl.create(:master_track)
    @mix_down = FactoryGirl.create(:mix_down)
    @track = FactoryGirl.create(:track)
  end

  context "post is sent to /api/projects/:project_id/comments" do
    it "should create a comment for that project" do
      comment_count = @project.comments.count
      post :create, :project_id => @project.id, :content => "comment"
      @project.comments.count.should eq(comment_count + 1)
      JSON.parse(response.body)['response'].should eq(true)
    end
  end

  context "post is sent to /api/projects/:project_id/master_tracks/:master_track_id/comments" do
    it "should create a comment for that master track" do
      comment_count = @master_track.comments.count
      post :create, :project_id => @project.id, :master_track_id => @master_track.id, :content => "comment"
      @master_track.comments.count.should eq(comment_count + 1)
      JSON.parse(response.body)['response'].should eq(true)
    end
  end

  context "post is sent to /api/projects/:project_id/mix_downs/:mix_down_id/comments" do
    it "should create a comment for that mix down" do
      comment_count = @mix_down.comments.count
      post :create, :project_id => @project.id, :mix_down_id => @mix_down.id, :content => "comment"
      @mix_down.comments.count.should eq(comment_count + 1)
      JSON.parse(response.body)['response'].should eq(true)
    end
  end

  context "post is sent to /api/projects/:project_id/tracks/:track_id/comments" do
    it "should create a comment for that track" do
      comment_count = @track.comments.count
      post :create, :project_id => @project.id, :track_id => @track.id, :content => "comment"
      @track.comments.count.should eq(comment_count + 1)
      JSON.parse(response.body)['response'].should eq(true)
    end
  end
end
