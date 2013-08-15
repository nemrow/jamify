class ProjectsController < ApplicationController
  def create
    project = Project.new(params[:new_project])
    user = User.find(params[:user_id])
    if project.save
      user.projects << project
      render json: {:response => true, :project_id => project.id}
    else
      render json: {:errors => 'could not save project to database'}
    end
  end

  def show
    project = Project.find(params[:id])
    json_hash = {}
    if project
      json_hash[:response] = true
      json_hash[:tracks] = project.tracks
      json_hash[:genres] = project.genres
      json_hash[:mix_downs] = project.mix_downs
      render :json => json_hash
    else
      json_hash[:response] = false
      render :json => json_hash
    end
  end
end
