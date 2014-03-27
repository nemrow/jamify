require 'spec_helper'
require "debugger"

describe ProjectsController do
  let (:user) { FactoryGirl.create(:user) }

  context "when a post request is sent to /api/users/:user_id/projects" do
    before do
      post :create, :user_id => user.id, :new_project => {:name => 'My Sweet Project'}
      @response_hash = JSON.parse(response.body)
    end

    it "should respond with {:response => true, :project_id => id}" do
      @response_hash['response'].should == true
      @response_hash['project_id'].should be_a_kind_of(Fixnum)
    end

    it "should create a new project" do
      response.should be_ok
      Project.count.should == 1
    end

    it "should be added to a users projects" do
      user.projects.count.should == 1
      user.projects.last.name.should == 'My Sweet Project'
    end
  end

  context "when a get request is sent to /api/projects/:id" do
    before do 
      @project = FactoryGirl.create(:project)
      @project.master_track = FactoryGirl.create(:master_track)
      10.times do 
        track = FactoryGirl.create(:track)
        4.times do
          comment = FactoryGirl.create(:comment)
          track.comments << comment
        end
        @project.tracks << track
      end
      3.times do 
        genre = FactoryGirl.create(:genre)
        @project.genres << genre
      end
      5.times do 
        mix_down = FactoryGirl.create(:mix_down)
        4.times do
          comment = FactoryGirl.create(:comment)
          mix_down.comments << comment
        end
        @project.mix_downs << mix_down
      end
      6.times do
        comment = FactoryGirl.create(:comment)
        @project.comments << comment
      end
      get :show, :id => @project.id
      @response_hash = JSON.parse(response.body)
    end

    it "should return response true" do
      @response_hash['response'].should == true
    end

    it "should return all tracks" do
      @response_hash['tracks'].count.should == 10
      @response_hash['tracks'][0]['comments'].count.should eq(4)
    end

    it "should return all genres" do
      @response_hash['genres'].count.should == 3
    end

    it "should return all mix_downs" do
      @response_hash['mix_downs'].count.should == 5
      @response_hash['mix_downs'][0]['comments'].count.should eq(4)
    end

    it "should return all comments" do
      @response_hash['comments'].count.should eq(6)
    end
  end
end
