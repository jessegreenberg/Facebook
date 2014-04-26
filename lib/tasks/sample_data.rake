namespace :db do
	desc "Fill database with sample data"

	task populate: :environment do
		make_users
		make_userposts
		make_relationships
	end

	def make_users
		User.create!(name: "Example User", email: "example@email.com", password: "foobar", password_confirmation: "foobar")
                99.times do |n|
                        name = Faker::Name.name
                        email = "example-#{n+1}@email.com"
                        password = "password"
                        User.create!(name: name, email: email, password: password, password_confirmation: password)
                end
	end

	def make_userposts
		users = User.all(limit: 6)
                50.times do
                        content = Faker::Lorem.sentence(5)
                        users.each { |user| user.userposts.create!(content: content) }
                end
	end

	def make_relationships
		users = User.all
		user = users.first
		
		first_group = users[2..25]
		
		first_group.each { |newfriend| user.make_friend_request(newfriend) }
	end

end
