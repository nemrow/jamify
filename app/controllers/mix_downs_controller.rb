class MixDownsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    project = Project.find(params[:project_id])
    mix_down = MixDown.new(params[:mix_down])
    if mix_down.save
      mix_down.add_bulk_tracks(params[:tracks])
      user.mix_downs << mix_down
      project.mix_downs << mix_down
      render :json => {:response => true, :mix_down_id => mix_down.id}
    else
      render :json => {:response => false}
    end
  end
end
