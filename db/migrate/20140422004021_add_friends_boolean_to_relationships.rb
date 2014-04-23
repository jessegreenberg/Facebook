class AddFriendsBooleanToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :friends, :string
  end
end
