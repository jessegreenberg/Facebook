class Userpost < ActiveRecord::Base
	# Everything needed to get user posts up and running!
	# Sets up the association needed between the two models.
	
	belongs_to :user
	validates :user_id, presence: true
end
