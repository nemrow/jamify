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

  def index
    if params['instrument']
      json_hash = {}
      json_hash[:response] = 'instrument'
      json_hash[:mix_downs] = get_mix_downs_by_instrument(params[:instrument], params[:quantity] || 10)
      render :json => json_hash
    elsif params[:genre]
      # duplicate instruments code but for genre
    else
      json_hash = {}
      json_hash[:response] = 'top 2'
      json_hash[:mix_downs] = MixDown.grab_top(params[:quantity] || 10)
      render :json => json_hash
    end
  end
end
