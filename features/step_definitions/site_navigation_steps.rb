
And /^the user visits their profile page$/ do
	visit user_path(@user)
end
	
And /^they are on the newsfeed page$/ do
	visit newsfeed_path(@user)
end

When /^they click on the profile tab$/ do
	within(".dropdown-menu") do
		click_link "Profile"
	end
end

And /^they are on the profile page$/ do
	visit user_path(@user)
end

When /^they click on the newsfeed tab$/ do
	click_link "Newsfeed"
end

Then /^they should see the newsfeed$/ do
	expect(page).to have_title("Facebook | #{@user.name}'s Newsfeed")
end

When /^they click on the friends link$/ do
	click_link "Friends"
end

Then /^they should see a list of their friends$/ do

	@usernames.each do |t|
		expect(page).to have_content(t)
	end
end

When /^they click on the profile preferences link$/ do
	click_link "Profile Preferences"
end

Then /^they should see a form for changing information$/ do
	expect(page).to have_field("Name")
	expect(page).to have_field("Email")
	expect(page).to have_field("Password")
	expect(page).to have_field("Confirm Password")
	expect(page).to have_selector(:link_or_button, "Save changes")
end

When /^they click on the Sign Out link$/ do
	click_link "Sign Out"
end
