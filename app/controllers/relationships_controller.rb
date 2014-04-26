class RelationshipsController < ApplicationController
	before_action :signed_in_user
	
	def create
		@user = User.find(params[:relationship][:friend_b_id])
		current_user.make_friend_request(@user)
		redirect_to @user
	end
	
	def destroy
		@user = Relationship.find(params[:id].friend_b)
		current_user.unfriend!(@user)
		redirect_to @user
	end
end
