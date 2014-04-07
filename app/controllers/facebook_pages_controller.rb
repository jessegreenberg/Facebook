class FacebookPagesController < ApplicationController
	def login
		render :layout => false
		@user = User.find(params[:id])
	end

  def newsfeed
  end
  
  def profile_preferences
  end
  
  def profile_page
  end
  
  def friend_list
  end
  
  def friend_search
  end
  
	def new
		@user = User.new
	end
	
end
