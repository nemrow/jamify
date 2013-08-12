require 'spec_helper'

describe Project do
  let (:user) { FactoryGirl.create(:user) }
  let (:project) { FactoryGirl.create(:project) }
  let (:master_track) { FactoryGirl.create(:master_track) }
  let (:genre) { FactoryGirl.create(:genre) }
  let (:track) { FactoryGirl.create(:track) }
  let (:mix_down) { FactoryGirl.create(:mix_down) }

  it "should add user as creator" do 
    project.creator = user
    project.creator.should == user
  end

  it "should add master track project" do 
    project.master_track = master_track
    project.master_track.should == master_track
  end

  it "should add genre to project list" do 
    project.genres << genre
    project.genres.count.should == 1
  end

  it "should add track to project" do
    project.tracks << track
    project.tracks.count.should == 1
  end

  it "should add mix_down to the project" do
    project.mix_downs << mix_down
    project.mix_downs.count.should == 1
  end

  it { should belong_to(:creator) }
  it { should have_one(:master_track) }
  it { should have_many(:genres) }
  it { should have_many(:tracks) }
end