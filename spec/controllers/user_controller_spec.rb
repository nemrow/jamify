require 'spec_helper'

describe UsersController do

  context "when post request sent to user/create with correct new user data" do
    it "adds a new user to database" do
      user_count = User.count
      post :create, {:new_user => {:first_name => 'Jordan', :last_name => 'Nemrow', :email => 'nemmy@nems.com', :sc_id => 56742}}
      response.should be_success
      User.count.should == user_count + 1
      result_hash = JSON.parse(response.body)
      result_hash['response'].should == true
    end
  end

  context "when get request sent to user/index with no data" do
    it "returns all users in database" do
      10.times do 
        FactoryGirl.create(:user)
      end
      get :index
      response.should be_success
      JSON.parse(response.body).count.should == 10
    end
  end

  context "when get request sent to user/show with email address parameter" do
    before do 
      @user = FactoryGirl.create(:user)
    end
    it "return the user associated to that email" do
      get :show, {:email => @user.email}
      response.should be_success
      result_hash = JSON.parse(response.body)
      result_hash['first_name'].should == @user.first_name
    end
  end
end
