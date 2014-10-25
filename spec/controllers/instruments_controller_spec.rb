require 'spec_helper'

describe InstrumentsController do
  context "when a post is sent to /api/tracks/:track_id/instruments" do
    let (:track) { FactoryGirl.create(:track) }

    before do
      post :create, :track_id => track.id, :instrument => {:name => 'Guitar'}
      @response_hash = JSON.parse(response.body)
    end

    it "should response with {:response => true}" do
      @response_hash['response'].should == true
    end

    it "should find the instrument and add it to this project" do
      track.instruments.last.name.should == 'guitar'
    end
  end
end
