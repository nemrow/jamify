class UsersController < ApplicationController
	def create
		user = User.new(params[:new_user])
		if user.save
			render json: {:response => true, :user_id => user.id}
		else
			render json: {:response => false}
		end
	end

	def index
		users = User.all.to_json
		render json: users
	end

	def show
		user = User.find_by_email(params[:email]) if params[:email]
		user = User.find(params[:user_id]) if params[:user_id]
		if user
			render json: {:response => true, :user => user}
		else
			render json: {:response => false}
		end
	end
end