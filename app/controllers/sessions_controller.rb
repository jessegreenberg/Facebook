class SessionsController < ApplicationController

	def new
	end
	
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash[:error] = 'Invalid email / password Combination'
			redirect_to new_user_path
		end
	end
	
	def destroy
		sign_out
		redirect_to new_user_url
	end
end
