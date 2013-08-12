require 'spec_helper'

describe GenresController do
  let (:project) { FactoryGirl.create(:project) }
  let (:genre_1) { Genre.create(:name => 'rap') }
  let (:genre_2) { Genre.create(:name => 'jazz') }

  context "when post sent to /api/projects/:project_id/genres for an existing genre" do
    it "should find the existing genre and add it to this project" do
      project.genres.count.should == 0
      post :create, :project_id => project.id, :genre => {:name => genre_1.name}
      response.should be_ok
      project.genres.count.should == 1
      project.genres.last.id.should == genre_1.id
    end
  end

  context "when post sent to /api/projects/:project_id/genres for a new genre" do
    it "should create new genre and add it to this project" do
      project.genres.count.should == 0
      genre_count = Genre.count
      post :create, :project_id => project.id, :genre => {:name => Faker::Lorem.word}
      response.should be_ok
      Genre.count.should == genre_count + 1
      project.genres.count.should == 1
    end
  end
end
