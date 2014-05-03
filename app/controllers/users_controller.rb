class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :index, :friends]
	before_action :correct_user, only: [:edit, :update]
	
	include UserHelper
	

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
		@user = User.find(params[:id])
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
	
	def newsfeed
		@user = User.find(params[:id])
		@possessive_name = possessive(@user.name)
		if signed_in?
			@userpost = current_user.userposts.build
			@newsfeed_items = current_user.newsfeed.paginate(page: params[:page])
		else
			redirect_to new_user_path
		end
	end

	def friends
		@user = User.find(params[:id])
		@possessive_name = possessive(@user.name)
		@friends = @user.friends.where("friendship_status = 2")
		@pending_friends = @user.friends.paginate(page: params[:page]).where("friendship_status = 1")
		render 'show_friends'
	end
	
	# Part of code from riseup.net
	def search
		@users = Users.all
		@user = User.search params[:search]
	end
	
	def search_results
		@users = User.search params[:search]
	end
	
	private	
		def user_params
			params.require(:user).permit!
		end
		
		# Before filters

		def correct_user
			@user = User.find(params[:id])
			redirect_to(new_user_url) unless current_user?(@user)
		end
end
