require 'spec_helper'

describe UsersController do

  context "when post request sent to /api/users" do
    before do
      post :create, {:new_user => {:first_name => 'Jordan', :last_name => 'Nemrow', :email => 'nemmy@nems.com', :sc_id => 56742}}
      @result_hash = JSON.parse(response.body)
    end

    it "should responde with {:response => true, :user_id => id}" do
      @result_hash['response'].should == true
      @result_hash['user_id'].should be_a_kind_of(Fixnum)
    end

    it "adds a new user to database" do
      response.should be_ok
      User.count.should == 1
      @result_hash['response'].should == true
    end
  end

  context "when get request sent to /api/users" do
    before do
      10.times do 
        FactoryGirl.create(:user)
      end
      get :index
    end

    it "returns all users in database" do
      JSON.parse(response.body).count.should == 10
    end
  end

  context "when get request sent to /api/users/email/:email" do
    let (:user) { FactoryGirl.create(:user) }

    before do 
      get :show, {:email => user.email}
      @result_hash = JSON.parse(response.body)
    end

    it "should return the response true" do
      @result_hash['response'].should == true
    end

    it "return the user associated to that email" do
      @result_hash['user']['id'].should == user.id
    end
  end

  context "when get request sent to /api/users/sc_id/:sc_id" do
    let (:user) { FactoryGirl.create(:user) }

    before do 
      get :show, {:sc_id => user.sc_id}
      @result_hash = JSON.parse(response.body)
    end

    it "should return the response true" do
      @result_hash['response'].should == true
    end

    it "return the user associated to that soundcloud id" do
      @result_hash['user']['id'].should == user.id
    end
  end

  context "when get request sent to /api/users/id/:user_id" do
    let (:user) { FactoryGirl.create(:user) }

    before do 
      get :show, {:user_id => user.id}
      @result_hash = JSON.parse(response.body)
    end

    it "should respond with true" do 
      @result_hash['response'].should == true
    end

    it "return the user associated to that email" do
      @result_hash['user']['id'].should == user.id
    end
  end
end
