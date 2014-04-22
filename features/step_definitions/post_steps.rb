When /^they enter a new status in the content box$/ do
	fill_in  'userpost_content', with: "Lorem Imspum"
end

And /^they click the share button$/ do
	click_button "Share"
end

Then /^they should see their post on their profile page$/ do
	expect(page).to have_content("Lorem Imspum")
end

And /^they should see their post on the Newsfeed$/ do
	visit newsfeed_path
	expect(page).to have_content("Lorem Imspum")
end

Given /^a user visits their profile page$/ do
	visit user_path
end
