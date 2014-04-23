class ChangeFriendsFormatInRelationships < ActiveRecord::Migration
	def change
		add_column :relationships, :friendship_status, :string
		remove_column :relationships, :friends, :boolean
	end
end
