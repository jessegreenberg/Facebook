class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :index]
	before_action :correct_user, only: [:edit, :update]

	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params) # Not the final.
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Facebook!"
			redirect_to @user
		else
			render 'new'
		end
	end
	
	def show
		@user = User.find(params[:id])
		# note that paginate can even work through association!
		@userposts = @user.userposts.paginate(page: params[:page])
		@userpost = current_user.userposts.build if signed_in?
	end
	
	def edit
		# Not needed in this function; handled in correct_user
		#@user = User.find(params[:id])
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	private	
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Before filters

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
end
