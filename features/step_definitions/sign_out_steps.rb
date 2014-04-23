And /^they should see the sign in page$/ do
	expect(page).to have_content("Sign In")
	expect(page).to have_content("Sign Up")
end

Then /^they should be logged out of facebook$/ do
	expect(page).to have_no_content("Profile")
	expect(page).to have_no_content("Newsfeed")
end
