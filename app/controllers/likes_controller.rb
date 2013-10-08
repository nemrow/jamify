class LikesController < ApplicationController
  def create
    render :json => {:response => Like.set_new_like(params)}
  end

  def index
    if params[:user_sc_id]
      user = User.find_by_sc_id(params[:user_sc_id])
      render :json => { :objects => Like.get_users_likes(user, params[:likeable_type]) }
    else
      render :json => { :users => Like.get_users_by_liked_object(params[:likeable_type], params[:likeable_id]) }
    end
  end

  def destroy
    render :json => {:response => Like.find(params[:like_id]).destroy}
  end
end
