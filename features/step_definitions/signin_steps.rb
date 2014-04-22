
When /^they submit an invalid name$/ do
	within(".center") do
		fill_in "Name", with: " "
		fill_in "Email", with: "example@example.com"
		fill_in "Password", with: "foobar"
		fill_in "Confirm Password", with: "foobar"
		click_button "Create Account"
	end
end

Then /^they should see the signin page$/ do
	expect(page).to have_content("Sign Up")
end

When /^they submit an invalid email$/ do
	within(".center") do
		fill_in "Name", with: "Example Name"
		fill_in "Email", with: "example@example"
		fill_in "Password", with: "foobar"
		fill_in "Confirm Password", with: "foobar"
		click_button "Create Account"
	end
end

When /^they submit a non-matching password$/ do
	within(".center") do
		fill_in "Name", with: " "
		fill_in "Email", with: "example@example.com"
		fill_in "Password", with: "foobar"
		fill_in "Confirm Password", with: "foobzarz"
		click_button "Create Account"
	end
end

When /^they submit valid sign up information$/ do
	within(".center") do
		fill_in "Name", with: "Example Name"
		fill_in "Email", with: "example@example.com"
		fill_in "Password", with: "foobar"
		fill_in "Confirm Password", with: "foobar"
		click_button "Create Account"
	end
end

Then /^they should see the profile page$/ do
	expect(page).to have_content("Example Name")
end
