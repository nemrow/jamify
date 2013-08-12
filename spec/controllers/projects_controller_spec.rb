require 'spec_helper'

describe ProjectsController do
  let (:user) { FactoryGirl.create(:user) }

  context "when a post request is sent to projects/create with accurate params" do 
    it "should add a new project to the db" do
      project_count = Project.count
      post :create, :user_id => user.id, :new_project => {:name => 'My Sweet Project'}
      response.should be_ok
      Project.count.should == project_count + 1
      JSON.parse(response.body)['response'].should == true
    end

    it "should be added to a users projects" do
      user_projects_count = user.projects.count
      post :create, :user_id => user.id, :new_project => {:name => 'My Sweet Project'}
      response.should be_ok
      user.projects.count.should == user_projects_count + 1
    end
  end
end
