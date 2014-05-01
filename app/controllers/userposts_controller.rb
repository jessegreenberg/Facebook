class UserpostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	
	def index
	end
	
	def create
		store_view
		@user = current_user
		@userpost = current_user.userposts.build(userpost_params)
		if @userpost.save
			flash[:success] = "Status Posted!"
			redirect_to(:back)
		else
			flash[:error] = 'Please enter post content.'
			# for now, send to profile page.
			redirect_to(:back)
		end
	end
	
	def destroy
		@userpost.destroy
		redirect_to newsfeed_path(current_user)
	end

	private
		
		def userpost_params
			params.require(:userpost).permit(:content)
		end

		def correct_user
			@userpost = current_user.userposts.find_by(id: params[:id])
			redirect_to newsfeed_path(user) if @userpost.nil?
		end
		
		def store_view
			session[:return_to] = request.url if request.get?
		end
end
