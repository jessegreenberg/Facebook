class AddFriendsBooleanToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :friends, :boolean
  end
end
