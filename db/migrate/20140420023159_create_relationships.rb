class CreateRelationships < ActiveRecord::Migration
	def change
		create_table :relationships do |t|

			t.integer :friend_a_id
			t.integer :friend_b_id
			
			t.timestamps
		end
		
		add_index :relationships, :friend_a_id
		add_index :relationships, :friend_b_id
		add_index :relationships, [:friend_a_id, :friend_b_id], unique: true

	end
end
