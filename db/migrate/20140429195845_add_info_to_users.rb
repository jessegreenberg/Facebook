class AddInfoToUsers < ActiveRecord::Migration
	def change
		add_column :users, :age, :integer
		add_column :users, :gender, :string
		add_column :users, :ocupation, :string
		add_column :users, :books, :text
		add_column :users, :movies, :text
		add_column :users, :bands, :text
		add_column :users, :song, :string
		add_column :users, :hobbies, :text
		add_column :users, :about_me, :text
	end
end
