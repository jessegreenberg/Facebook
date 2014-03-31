require 'spec_helper'

describe "Facebook Pages" do	
	describe "Login Page" do
		it "should have the content 'facebook'" do
			visit '/facebook_pages/login'
			expect(page).to have_content('facebook')
		end
		it "should have the title 'Welcome to Facebook | Log In or Sign Up!'" do
			visit '/facebook_pages/login'
			expect(page).to have_title("Welcome to Facebook | Log In or Sign Up!")
		end
	end
	
	describe "Newsfeed" do
		it "should have the content 'Newsfeed'" do
			visit '/facebook_pages/newsfeed'
			expect(page).to have_content('Newsfeed')
		end
		it "should have the title 'Facebook | Newsfeed'" do
			visit '/facebook_pages/newsfeed'
			expect(page).to have_title("Facebook | Newsfeed")
		end
	end
	
	describe "Profile Preferences" do
		it "should have the title 'Facebook | Profile Preferences'" do
			visit '/facebook_pages/profile_preferences'
			expect(page).to have_title("Facebook | Profile Preferences")
		end
		it "should have the content 'Profile Preferences'" do
			visit '/facebook_pages/profile_preferences'
			expect(page).to have_content('Profile Preferences')
		end
	end
	describe "Profile Page" do
		it "should have the title 'Facebook | Profile Page'" do
			visit '/facebook_pages/profile_page'
			expect(page).to have_title("Facebook | Profile")
		end
		it "should have the content 'Profile Page'" do
			visit '/facebook_pages/profile_page'
			expect(page).to have_content('Profile')
		end
	end
	describe "Friend List" do
		it "should have the title 'Facebook | Friends'" do
			visit '/facebook_pages/friend_list'
			expect(page).to have_title("Facebook | Friends")
		end
		it "should have the content 'Friends'" do	
			visit '/facebook_pages/friend_list'
			expect(page).to have_content('Friends')
		end
	end
	describe "Search Page" do
		it "should have the title 'Facebook | Friend Search'" do
			visit '/facebook_pages/friend_search'
			expect(page).to have_title("Facebook | Friend Search")
		end
		it "sould have the content 'Friend Search'" do
			visit '/facebook_pages/friend_search'
			expect(page).to have_content('Friend Search')
		end
	end
end
