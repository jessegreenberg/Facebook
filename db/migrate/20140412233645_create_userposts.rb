class CreateUserposts < ActiveRecord::Migration
  def change
    create_table :userposts do |t|
      t.string :content
      t.integer :user_id

		# creates the created at and updated at columns.
      t.timestamps
    end
    
    # Create a multiple key index.  
    add_index :userposts, [:user_id, :created_at]
  end
end
