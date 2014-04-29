class Userpost < ActiveRecord::Base
	# Everything needed to get user posts up and running!
	# Sets up the association needed between the two models.
	
	belongs_to :user

	# created_at DESC declares that we want the SQL order to be descending, newest to oldest.
	# lambda function - - - takes a block and then calles the function in the block
	# when used with call.
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :content, presence: true
	
	def self.from_friends_of(user)
		#friend_ids = user.relationships.find_by(friendship_status: 2)
		where("user_id IN (?) OR user_id = ?", friend_ids, user)
	end
end
