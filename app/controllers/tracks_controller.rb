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
      render :json => {:response => false, :reason => 'could not save new track'}
    end
  end

  def show
    track = Track.find_by_sc_id(params[:track_sc_id])
    if track
      render :json => {:response => true, :track => track.with_associations}
    else
      render :json  => {:response => false, :reason => "Could not find user with that soundcloud id"}
    end
  end
end
