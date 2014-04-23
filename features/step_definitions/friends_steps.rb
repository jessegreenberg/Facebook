
And /^the user has friends$/ do
	@friend1 = User.create(name: "Thomas", email: "thomas@thomas.com", password: "foobar", password_confirmation: "foobar")
	@friend2 = User.create(name: "Alexa", email: "alexa@malexa.com", password: "foobar", password_confirmation: "foobar")
	@friend3 = User.create(name: "Marley", email: "marley@marley.com", password: "foobar", password_confirmation: "foobar")
	
	@usernames = [@friend1.name, @friend2.name, @friend3.name]
	
	@usernames.each do |name|
		visit users_path
		click_link name
		click_button "Send Friend Request"
	end
end	
		
