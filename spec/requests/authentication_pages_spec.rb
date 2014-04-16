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
			before { click_button "Sign In" }
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
			it { should have_link('Profile Preferences', href: edit_user_path(user)) }
			it { should have_link('Sign Out', href: signout_path) }
			it { should have_link('Friends', href: users_path) }
			it { should_not have_link('Sign In', href: new_user_path) }

			describe "followed by signout" do
				before { click_link "Sign Out" }
				it { should have_link('Sign In') }
			end
		end
	end

	describe "authorization" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			
			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					within(".foo") do
						fill_in "Email", with: user.email
						fill_in "Password", with: user.password
						click_button "Sign In"
					end
				end
				
				describe "after signing in" do
					
					it "should render the previously desired protected page" do
						expect(page).to have_title('Facebook | Preferences')
					end
				end
			end

			describe "in the Users controller" do

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_title('Facebook | Log In or Sign Up!') }
				end

				describe "submitting to the update action" do
					before { patch user_path(user) }
					specify { expect(response).to redirect_to(new_user_path) }
				end

				describe "visiting the user index" do
					before { visit users_path }
					it { should have_title('Facebook | Log In or Sign Up!') }
				end
			end

			describe "in the Userposts controller" do

				describe "submitting to the create action" do
					before {post userposts_path }
					specify { expect(response).to redirect_to(new_user_path) }
				end

				describe "submitting the destroy action" do
					before { delete userpost_path(FactoryGirl.create(:userpost)) }
					specify { expect(response).to redirect_to(new_user_path) }
				end
			end
				
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the Users#edit action" do
				before { get edit_user_path(wrong_user) }
				specify { expect(response).to redirect_to(new_user_url) }
			end

			describe "submitting a PATCH request to the Users#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(new_user_url) }
			end
		end
	end
end
