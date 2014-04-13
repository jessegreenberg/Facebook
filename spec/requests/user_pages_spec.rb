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
	
	describe "edit" do
    		let(:user) { FactoryGirl.create(:user) }
    		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "with valid information" do
			let(:new_name)  { "New Name" }
			let(:new_email) { "new@example.com" }
			before do
				fill_in "Name",             with: new_name
        			fill_in "Email",            with: new_email
        			fill_in "Password",         with: user.password
        			fill_in "Confirm Password", with: user.password
        			click_button "Save changes"
      			end

     			it { should have_selector('div.alert.alert-success') }
      			it { should have_link('Sign out', href: signout_path) }
      			specify { expect(user.reload.name).to  eq new_name }
      			specify { expect(user.reload.email).to eq new_email }
		end
	end

    	describe "page" do
      		it { should have_content("Update your profile") }
      		it { should have_title("Facebook | Preferences") }
    	end

    	describe "with invalid information" do
      		before { click_button "Save changes" }

      		it { should have_content('error') }
    	end
  end
end
	
