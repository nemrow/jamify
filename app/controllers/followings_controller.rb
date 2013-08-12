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
end
