Given /^a user visits the signin page$/ do
	visit new_user_path
end

When /^they submit invalid signin information$/ do
	click_button "Sign In"
end

Then /^they should see an error message$/ do
	expect(page).to have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
	@user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
end

When /^the user submits valid signin information$/ do
	within(".new") do
		fill_in "Email", with: @user.email
		fill_in "Password", with: @user.password
		click_button "Sign In"
	end
end

Then /^they should see their profile page$/ do
	expect(page).to have_title(@user.name)
end

Then /^they should see a signout link$/ do
	expect(page).to have_link('Sign Out', href: signout_path)
end

Given /^the user is logged in to facebook$/ do
	@user = User.create(name: "Example User", email: "example@example.com", password: "foobar", password_confirmation: "foobar")

	visit new_user_path
	
	within(".new") do
		fill_in "Email", with: @user.email
		fill_in "Password", with: @user.password
		click_button "Sign In"
		
	end
end

	
	
	
	
	
	
