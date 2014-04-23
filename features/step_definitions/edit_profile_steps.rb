
When /^the user enters new information in the form$/ do
	fill_in "Name", with: "New Name"
	fill_in "Email", with: "new_email@new.com"
	fill_in "Password", with: "NEWPASSWORD"
	fill_in "Confirm Password", with: "NEWPASSWORD"
end

And /^the user presses the save changes button$/ do
	click_button "Save changes"
end

Then /^the user should see their profile page with updated content$/ do
	expect(page).to have_content("New Name")
end

And /^the user should be notified of successful update$/ do
	expect(page).to have_content("Profile updated")
end

When /^the user enters invalid information$/ do
	fill_in "Name", with: " "
	fill_in "Email", with: "notanemail"
	fill_in "Password", with: "foobad"
	fill_in "Confirm Password", with: "foogood"
end

Then /^the user should see the profile preferences page$/ do
	expect(page).to have_field("Name")
	expect(page).to have_field("Email")
	expect(page).to have_field("Password")
	expect(page).to have_field("Confirm Password")
end

Then /^the user should be notified of an unsuccessful update$/ do
	expect(page).to have_content(/(The form contains) \d (errors)/)
end
