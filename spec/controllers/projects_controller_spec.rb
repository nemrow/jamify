require 'spec_helper'

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
        @project.tracks << track
      end
      3.times do 
        genre = FactoryGirl.create(:genre)
        @project.genres << genre
      end
      5.times do 
        mix_down = FactoryGirl.create(:mix_down)
        @project.mix_downs << mix_down
      end
      get :show, :id => @project.id
      @response_hash = JSON.parse(response.body)
    end

    it "should return response true" do
      @response_hash['response'].should == true
    end

    it "should return all tracks" do
      @response_hash['tracks'].count.should == 10
    end

    it "should return all genres" do
      @response_hash['genres'].count.should == 3
    end

    it "should return all mix_downs" do
      @response_hash['mix_downs'].count.should == 5
    end
  end
end
