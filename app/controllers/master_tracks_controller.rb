class MasterTracksController < ApplicationController
  def create
    master_track = MasterTrack.new(params[:master_track])
    user = User.find(params[:user_id])
    project = Project.find(params[:project_id])
    if master_track.save
      user.master_tracks << master_track
      project.master_track = master_track
      render :json => {:response => true, :master_track_id => master_track.id}
    else
      render :json => {:response => false}
    end
  end
end
