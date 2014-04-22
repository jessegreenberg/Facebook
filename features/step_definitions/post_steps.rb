When /^the user enters content in the post box$/ do
	fill_in  'userpost_content', with: "Lorem Imspum"
end

And /^they click the share button$/ do
	click_button "Share"
end

Then /^they should see their post on their profile page$/ do
	expect(page).to have_content("Lorem Imspum")
end

And /^they should see their post on the Newsfeed$/ do
	visit newsfeed_path(@user)
	expect(page).to have_content("Lorem Imspum")
end

Given /^a user visits their profile page$/ do
	@user = FactoryGirl.create(:user)
	before { sign_in user }
end
