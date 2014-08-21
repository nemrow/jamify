require 'spec_helper'

describe SearchController do
  context "when a post is sent to /api/search/:keywords" do

  let (:user) { FactoryGirl.create(:user) }
  let (:project) { FactoryGirl.create(:project) }
  let (:track_1) { FactoryGirl.create(:track) }
  let (:track_2) { FactoryGirl.create(:track) }
  let (:track_3) { FactoryGirl.create(:track) }

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

    it "should respond with 12 mix_downs" do
      get :search_all, :keywords => ["guitar"]
      @response_hash = JSON.parse(response.body)
      @response_hash['mix_downs'].count.should == 12
    end

    it "should respond with 0 mix_downs" do
      get :search_all, :keywords => ["piano"]
      @response_hash = JSON.parse(response.body)
      @response_hash['mix_downs'].count.should == 0
    end
  end
end
