class ProjectsController < ApplicationController
  def create
    project = Project.new(params[:new_project])
    user = User.find(params[:user_id])
    if project.save
      user.projects << project
      render json: {:response => true}
    else
      render json: {:errors => 'could not save project to database'}
    end
  end
end
