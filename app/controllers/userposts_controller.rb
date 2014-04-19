class UserpostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	
	def index
	end
	
	def create
		@user = current_user
		@userpost = current_user.userposts.build(userpost_params)
		if @userpost.save
			flash[:success] = "Status Posted!"
			redirect_to user_url(current_user)
		else
			flash[:error] = 'Please enter post content.'
			# for now, send to profile page.
			redirect_to user_url(current_user)
		end
	end
	
	def destroy
	end

	private
		
		def userpost_params
			params.require(:userpost).permit(:content)
		end
end
