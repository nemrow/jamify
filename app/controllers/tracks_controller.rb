class TracksController < ApplicationController
  def create
    user = User.find(params[:user_id])
    project = Project.find(params[:project_id])
    track = Track.new(params[:track])
    if track.save
      user.tracks << track
      project.tracks << track
      render :json => {:response => true, :track_id => track.id}
    else
      render :json => {:response => false}
    end
  end
end
