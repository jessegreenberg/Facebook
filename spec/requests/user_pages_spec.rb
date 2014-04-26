require 'spec_helper'

describe "User Pages" do
	subject { page }
	
	describe "sign up" do
		before { visit new_user_path }
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
		let!(:m1) { FactoryGirl.create(:userpost, user: user, content: "This is my first post") }
		let!(:m2) { FactoryGirl.create(:userpost, user: user, content: "This is another post") }
		before do
			sign_in user
			visit user_path(user)
		end
		
		it { should have_content(user.name) }
		it { should have_title("Facebook | #{user.name}") }

		describe "userposts" do
			it { should have_content(m1.content) }
			it { should have_content(m2.content) }
		end
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

     			it { should have_selector("div.alert.alert-success") }
      			it { should have_link('Sign Out', href: signout_path) }
      			specify { expect(user.reload.name).to  eq new_name }
      			specify { expect(user.reload.email).to eq new_email }
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

	describe "index" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			FactoryGirl.create(:user, name: "Doug", email: "DougFresh@example.com")
			FactoryGirl.create(:user, name: "Nick", email: "NickSuperFly@example.com")
			visit users_path 
		end

		it { should have_title('Facebook | All Users') }
		it { should have_content('All Users') }
		
		it "should list all users" do
			User.all.each do |user|
				expect(page).to have_selector('li', text:user.name)
			end
		end

		describe "pagination" do	
			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }

			it { should have_selector('div.pagination') }

			it "should list each user" do
				User.paginate(page: 1).each do |user|
					expect(page).to have_selector('li', text: user.name)
				end
			end
		end
	end
	
	describe "newfeed" do
		let(:user) { FactoryGirl.create(:user) }
		
		describe "for signed in users" do
			
			before do
				FactoryGirl.create(:userpost, user: user, content: "Lorem impsum")
				#FactoryGirl.create(:userpost, user: user, content: "Dolor sit amet")
				
				sign_in user
				visit newsfeed_path(user)
			end
			
			it "should render the user's feed" do
				user.newsfeed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end
		end
	end
		
	describe "Friend list" do
		let(:user) { FactoryGirl.create(:user) }
		let(:other_user) { FactoryGirl.create(:user) }
		
		describe "should show a list of the users friends" do
			before do
				user.make_friend_request(other_user)
				other_user.accept_friend_request!(user)
				sign_in user
				visit friends_user_path(user)
			end

			it { should have_title("Facebook | #{user.name}'s Friends") }
			it { should have_selector('h1', text: "Friends") }
			it { should have_link(other_user.name, href: user_path(other_user)) }
		end

		describe "user should be on friend list of the other user" do
			before do
				user.make_friend_request(other_user)
				other_user.accept_friend_request!(user)
				sign_in other_user
				visit friends_user_path(other_user)
			end

			it { should have_title("Facebook | #{other_user.name}'s Friends") }
			it { should have_selector('h1', text: "Friends") }
			it { should have_link(user.name, href: user_path(user)) }
			
		end
	end

end
	
