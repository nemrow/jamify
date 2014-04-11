require 'spec_helper'

describe MixDownsController do
  context "when a post is sent to /api/projects/:project_id/mix_downs" do

  let (:user) { FactoryGirl.create(:user) }
  let (:project) { FactoryGirl.create(:project) }
  let (:track_1) { FactoryGirl.create(:track) }
  let (:track_2) { FactoryGirl.create(:track) }
  let (:track_3) { FactoryGirl.create(:track) }
    
    before do
      post :create, :project_id => project.id, :user_id => user.id, 
        :mix_down => {:name => 'My MixDown', :sc_id => 45224},
        :tracks => "#{track_1.id}, #{track_2.id}, #{track_3.id}"
      @response_hash = JSON.parse(response.body)
    end

    it "should respond with {:response => true, mix_down_id => id}" do
      @response_hash['response'].should == true
      @response_hash['mix_down_id'].should be_a_kind_of(Fixnum)
    end

    it "should create a new mix_down" do
      response.should be_ok
      @response_hash['response'].should == true
    end

    it "should assign mix_down to user" do
      response.should be_ok
      project.mix_downs.count.should == 1
      user.mix_downs.last.id.should == @response_hash['mix_down_id']
    end

    it "should assign mix_down to project" do
      project.mix_downs.last.id.should == @response_hash['mix_down_id']
    end

    it "should assign each included track to the mix_down" do
      project.mix_downs.last.tracks.count.should == 3
    end
  end

  context "When a get is sent to /api/feed" do
    before :each do
      genre_1 = Instrument.create(:name => 'guitar')
      genre_2 = Instrument.create(:name => 'bass')
      12.times do
        user = FactoryGirl.create(:user)
        mix_down = FactoryGirl.create(:mix_down)
        user.mix_downs << mix_down
        5.times do 
          track = FactoryGirl.create(:track)
          user.tracks << track
          track.instruments << genre_2
          track.instruments << genre_1
          mix_down.tracks << track
        end
      end
      3.times do 
        new_mix = FactoryGirl.create(:mix_down)
        user = FactoryGirl.create(:user)
        user.mix_downs << new_mix
        new_track = FactoryGirl.create(:track)
        user_2 = FactoryGirl.create(:user)
        user_2.tracks << new_track
        new_mix.tracks << new_track
        new_instrument = Instrument.create(:name => 'flute')
        new_track.instruments << new_instrument
      end
    end

    context "when no params are included" do
      it "should return top 10 recent mix_downs" do
        get :index
        @response_hash = JSON.parse(response.body)
        @response_hash['mix_downs'].count.should == 10
      end

    end

    context "when instrument param is included" do
      it "should return top ten track with that genre" do
        get :index, :instrument => 'flute'
        @response_hash = JSON.parse(response.body)
        @response_hash['mix_downs'].count.should == 3
        @response_hash['mix_downs'][0]['collaborators'].count.should eq(1)
      end
    end

    context "when quantity param is included" do
      it "should return that number of tracks" do
        get :index, :quantity => 5
        @response_hash = JSON.parse(response.body)
        @response_hash['mix_downs'].count.should == 5
      end
    end
  end

  context "when an api request is sent to  /api/users/:user_id/mix_downs" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      3.times do 
        mix_down = FactoryGirl.create(:mix_down)
        4.times do
          comment = FactoryGirl.create(:comment)
          mix_down.comments << comment
        end
        @user.mix_downs << mix_down
      end
    end

    it "should return all the users mixdowns" do
      get :users_mixdowns, :user_id => @user.id
      response_hash = JSON.parse(response.body)
      response_hash['response'].should eq(true)
      response_hash['mix_downs'][0]['comments'].count.should eq(4)
    end
  end
end
