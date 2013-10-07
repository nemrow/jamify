class FollowingsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    following = User.find(params[:following_id])
    if user && following
      user.followings << following
      render :json => {:response => true}
    else
      render :json => {:response => false}
    end
  end

  def follows
    user = User.find_by_sc_id(params[:user_sc_id])
    render :json => {:users => user.get_users_followings}
  end

  def followed_by
    user = User.find_by_sc_id(params[:user_sc_id])
    render :json => {:users => user.get_users_followed_by}
  end
end
