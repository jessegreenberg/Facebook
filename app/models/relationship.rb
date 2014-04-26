class Relationship < ActiveRecord::Base

	belongs_to :friend_a, class_name: "User"
	belongs_to :friend_b, class_name: "User"
	validates :friend_a_id, presence: true
	validates :friend_b_id, presence: true
	validates :friendship_status, presence: true
	
end
