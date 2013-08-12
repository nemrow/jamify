class GenresController < ApplicationController
  def create
    project = Project.find(params[:project_id])
    genre = Genre.find_or_create_by_name(params[:genre][:name])
    if genre
      project.genres << genre
      render :json => {:response => true}
    else
      render :json => {:response => false}
    end
  end
end
