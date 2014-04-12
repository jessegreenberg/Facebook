require 'spec_helper'

describe "User Pages" do
	subject { page }
	
	describe "sign up" do
		before { visit root_path }
		let(:submit) { "Create Account" }

		describe "with valid information" do
		
			before do
				within(".row") do
					fill_in "Name", with: "Example User"
					fill_in "Email", with: "user@example.com"
					fill_in "Password", with: "foobar"
					fill_in "Confirm Password", with: "foobar"
				end
			end
			
			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
			
			describe "after saving the user" do
				before {click_button "Create Account"}
				let(:user) { User.find_by(email: 'user@example.com') }
				
				it { should have_link('Sign Out') }
			end
		end
	end

	
	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		
		it { should have_content(user.name) }
		it { should have_title("Facebook | #{user.name}") }
	end
	

end
	
