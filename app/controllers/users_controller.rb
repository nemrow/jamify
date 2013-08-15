class UsersController < ApplicationController
	def create
		user = User.new(params[:new_user])
		if user.save
			render json: {:response => true, :user_id => user.id}
		else
			render json: {:errors => 'could not save user to database'}
		end
	end

	def index
		users = User.all.to_json
		render json: users
	end

	def show
		user = User.find_by_email(params[:email])
		if user
			render json: user.to_json
		else
			render json: {:errors => 'no user with that email'}
		end
	end
end