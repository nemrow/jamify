require 'spec_helper'

describe Project do
  before do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    @master_track = FactoryGirl.create(:master_track)
    @genre = FactoryGirl.create(:genre)
    @track = FactoryGirl.create(:track)
    @mix_down = FactoryGirl.create(:mix_down)
  end

  it "should add user as creator" do 
    @project.creator = @user
    @project.creator.should == @user
  end

  it "should add master track project" do 
    @project.master_track = @master_track
    @project.master_track.should == @master_track
  end

  it "should add genre to project list" do 
    list_count = @project.genres.count
    @project.genres << @genre
    @project.genres.count.should == list_count + 1
  end

  it "should add track to project" do
    track_count = @project.tracks.count
    @project.tracks << @track
    @project.tracks.count.should == track_count + 1
  end

  it "should add mix_down to the project" do
    mix_down_count = @project.mix_downs.count
    @project.mix_downs << @mix_down
    @project.mix_downs.count.should == mix_down_count + 1
  end

  it { should belong_to(:creator) }
  it { should have_one(:master_track) }
  it { should have_many(:genres) }
  it { should have_many(:tracks) }
end