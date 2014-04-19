require 'spec_helper'

describe "UserpostPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "userpost creation" do
		before { visit user_path(user) }
		
		describe "with invalid information" do
			
			it "should not create a userpost" do
				expect { click_button "Share" }.not_to change(Userpost, :count)
			end

			describe "error messages" do
				before { click_button "Share" }
				it { should have_content('Please enter post content') }
			end
		end
		
		describe "with valid informatino" do
			
			before { fill_in  'userpost_content', with: "Lorem Imspum" }
			
			it "should create a userpost" do
				expect { click_button "Share" }.to change(Userpost, :count).by(1)
			end
		end
	end

	describe "userpost destruction" do
		before { FactoryGirl.create(:userpost, user: user) }

		describe "as a logged in user" do
			before { visit newsfeed_path(user) }
			
			it "should delete a post" do
				expect { click_link "delete" }.to change(Userpost, :count).by(-1)
			end
		end
	end
end
