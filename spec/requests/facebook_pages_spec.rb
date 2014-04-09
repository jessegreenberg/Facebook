=begin
require 'spec_helper'

describe "Facebook Pages" do
	subject { page }
	let(:user) { FactoryGirl.create(:user) }
=begin
	MOST OF THESE ARE NOW OBSOLETE.  NEW USERS STRUCTURE MADE THEM
	ARBITRARY.  COMMENTING OUT THE UNNECESSARY TESTS
=end

=begin
	
	describe "Login Page" do
		before { visit root_path }
		it { should have_content("facebook") }
		it { should have_content("Sign Up") }
		it { should have_title("Welcome to Facebook | Log In or Sign Up!") }
		
		# For Login Functionality:
		let(:submit){ "Create my account" }
		
		describe "with invalid information"
			it "should not create a user" do
				expect {click_button submit}.not_to change(User, :count)
			end
		
		describe "with valid information" do
			before do
				fill_in "Name", with: "Example User"
				fill_in "Email", with: "user@example.com"
				fill_in "Password", with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end
			
			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
=end
=begin
	
	describe "Newsfeed" do
		before { visit newsfeed_path }
		it { should have_content("Newsfeed") }
		it { should have_title("Facebook | Newsfeed") }
	end

	describe "Profile Preferences" do
		before { visit preferences_path }
		it { should have_content("Profile Preferences") }
		it { should have_title("Facebook | Profile Preferences") }
	end
=begin
	describe "Profile Page" do
		before { visit profile_path }
		it { should have_content("Profile Page") }
		it { should have_title("Facebook | Profile Page") }
	end
=end
=begin
	describe "Friend List" do
		before { visit friends_path }
		it { should have_content("Friends") }
		it { should have_title("Facebook | Friends") }
	end

	describe "Search Page" do
		before { visit results_path }
		it { should have_content("Friend Search") }
		it { should have_title("Facebook | Friend Search") }
	end
end

=end
