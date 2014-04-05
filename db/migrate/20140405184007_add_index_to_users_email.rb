class AddIndexToUsersEmail < ActiveRecord::Migration
	def change
		#add index is a method which adds an index to the email column 
		#of the users table.  Index itself does not add uniquenss but
		#unique: true parameter does.
		
		# Adding an index also makes for much faster attribute lookup!
		add_index :users, :email, unique: true
	end
end
