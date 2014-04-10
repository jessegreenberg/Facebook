require 'spec_helper'

describe "Authentication" do

	subject {page}
	
	describe "Home/Login/Log on page" do
		before {visit new_user_path}
		
		it { should have_content('Sign In') }
		it { should have_title('Welcome to Facebook | Log In or Sign Up!') }
	end
	
	describe "The signin action" do
		before {visit new_user_path}
		
		describe "with invalid information" do
			# have_selector checks for a particular HTML tag.
			it { should have_selector('div.alert.alert-error') }
		end
		
		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email", with: user.email.upcase, :match => :first
				fill_in "Password", with: user.password, :match => :first
				click_button "Sign In"
			end
			
			#have_link is a capybara method to ensure an anchor tag
			# in html has the correct text and optionally the coreect
			# link location.
			it { should have_title("Facebook | Newsfeed") }
			it { should have_link('Profile', href: user_path(user)) }
			it { should have_link('Sign Out', href: signout_path) }
			it { should_not have_link('Sign In', href: signin_path) }

			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end
		end
	end
end
