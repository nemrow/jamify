require 'spec_helper'

describe GenresController do
  let (:project) { FactoryGirl.create(:project) }
  let (:genre_1) { Genre.create(:name => 'rap') }
  let (:genre_2) { Genre.create(:name => 'jazz') }

  context "when post sent to /api/projects/:project_id/genres for an existing genre" do
    before do
      post :create, :project_id => project.id, :genre => {:name => genre_1.name}
      @response_hash = JSON.parse(response.body)
    end

    it "should respond with {:response => true}" do
      @response_hash['response'].should == true
    end

    it "add a genre association table" do
      response.should be_ok
      ProjectGenre.count.should == 1
      project.genres.last.id.should == genre_1.id
    end

    it "should assign genre to project" do
      project.genres.count.should == 1
      project.genres.last.id.should == genre_1.id
    end
  end

  context "when post sent to /api/projects/:project_id/genres for a new genre" do
    before do
      post :create, :project_id => project.id, :genre => {:name => 'Alternative'}
    end

    it "add a genre association table" do
      response.should be_ok
      ProjectGenre.count.should == 1
      project.genres.last.name.should == 'Alternative'
    end

    it "should assign genre to project" do
      project.genres.count.should == 1
      project.genres.last.name.should == 'Alternative'
    end
  end
end
