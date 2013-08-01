class UsersController < ApplicationController
	def create
		user = User.create(params[:new_user])
		if user.save
			render json: {:response => true}
		else
			render json: {:response => response, :errors => 'could not save user to database'}
		end
	end
end