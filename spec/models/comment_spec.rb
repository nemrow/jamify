require 'spec_helper'
require "debugger"

describe Comment do
  before(:each) do
    @project = FactoryGirl.create(:project) 
    @comment = FactoryGirl.create(:comment) 
    @master_track = FactoryGirl.create(:master_track)
    @mix_down = FactoryGirl.create(:mix_down)
  end

  it "add comment to project" do
    comment_count = @project.comments.count
    @project.comments << @comment
    @project.comments.count.should eq(comment_count + 1)
  end

  it "should add comment to master track" do
    comment_count = @master_track.comments.count
    @master_track.comments << @comment
    @master_track.comments.count.should eq(comment_count + 1)
  end

  it "should add comment to mix_down" do
    comment_count = @mix_down.comments.count
    @mix_down.comments << @comment
    @mix_down.comments.count.should eq(comment_count + 1)
  end
end
