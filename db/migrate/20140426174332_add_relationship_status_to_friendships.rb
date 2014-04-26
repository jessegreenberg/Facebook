class AddRelationshipStatusToFriendships < ActiveRecord::Migration
  def change
	remove_column :relationships, :friendship_status, :string
	add_column :relationships, :friendship_status, :integer
  end
end
