require 'spec_helper'

describe ProjectsController do
  let (:user) { FactoryGirl.create(:user) }

  context "when a post request is sent to projects/create with accurate params" do
    before do
      post :create, :user_id => user.id, :new_project => {:name => 'My Sweet Project'}
      @response_hash = JSON.parse(response.body)
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
end
