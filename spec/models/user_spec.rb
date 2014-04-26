require 'spec_helper'

describe User do

	before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }
	
	subject { @user }

	# General attributes in the schema
	it { should respond_to(:name) }
	it { should respond_to(:email) }
	
	# pasword_digest will hold the hashed version of the password
	it { should respond_to(:password_digest) }
	
	# the following are for password creation - ensure they are equal
	# BEFORE saving to the db.
	it {should respond_to(:password) }
	it {should respond_to(:password_confirmation) }
	
	#Session token response:
	it { should respond_to(:remember_token) }
	
	# password authentication
	it { should respond_to(:authenticate)}
	
	# Userpost association validation ADMIN GETS ADDED LATER if desired
	## it { should respond_to(:admin) }
	it { should respond_to(:userposts) }
	
	#existence validation
	it { should be_valid }
	
	# Check for existence of a newsfeed specific to the user.
	it { should respond_to(:newsfeed) }

 	# Check for existence of the relationship structure
	it { should respond_to(:relationships) }
	
	# Check for existence of friendship model through the relationship structure
	it { should respond_to(:friends) }

	# Check for existence of methods for friend/relationship creating
	it { should respond_to(:friends_with?) }
	it { should respond_to(:make_friend_request) }
	it { should respond_to(:unfriend!) }
	it { should respond_to(:accept_friend_request!) }
	
	describe "When name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end
	
	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end
	
	describe "when the user name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end
	
	describe "When email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end
	
	describe "When email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org first.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end
	
	describe "when email address is already taken" do
		before do
			# dup method creates a copy of the user
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		
		it { should_not be_valid }
	end
	
	describe "when password is not present" do
		before do
			@user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
		end
		it { should_not be_valid }
	end
	
	describe "when password doesnt match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end
	
	# The case where they DO match is already covered by line ' it {should be_valid}
	
	# There is a ton goin on here, go back and understand it.
	# A LOT of the functionality is (if not ALL) is implemented with
	# has_secure_password.  that method requires specific test names
	# like password_confirmation.
	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }
		
		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end
		
		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end
	
	describe "Creating a password that is too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
	end
	
	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end

	describe "userpost associations" do
		before { @user.save }
		let!(:older_userpost) do
			FactoryGirl.create(:userpost, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_userpost) do
			FactoryGirl.create(:userpost, user: @user, created_at: 1.hour.ago)
		end

		it "should have the older post ordered second" do
			expect(@user.userposts.to_a).to eq [newer_userpost, older_userpost]
		end
		
		describe "status" do
			let(:unfollowed_post) do
				FactoryGirl.create(:userpost, user: FactoryGirl.create(:user) )
			end
			
			its(:newsfeed) { should include(newer_userpost) }
			its(:newsfeed) { should include(older_userpost) }
			its(:newsfeed) { should_not include(unfollowed_post) }
		end	
				
	end

	describe "When creating a friendship" do
	
		let(:other_user) { FactoryGirl.create(:user) }
		before do
			@user.save
		end
	
		describe "sending a friend request" do
			
			before do
				@user.make_friend_request(other_user) 
			end
			
			it { should_not be_friends_with(other_user) }
			
		
			describe "accepting a friend request" do
				before { other_user.accept_friend_request!(@user) }
				it { should be_friends_with(other_user) }
				its(:friends) { should include(other_user) }
		
				describe "the relationship should be mutual" do
		
					subject { other_user }
	
					it { should be_friends_with(@user) }
					its(:friends) { should include(@user) }
				end
			end
		end
	end

	describe "When deleting friends" do

		let(:other_user) { FactoryGirl.create(:user) }
		before do
			@user.save
			@user.make_friend_request(other_user)
			other_user.accept_friend_request!(@user)
		end

		before { @user.unfriend!(other_user) }
		
		describe "the user should no longer be friends with the other user" do
			it { should_not be_friends_with(other_user) }
			its(:friends) { should_not include(other_user) }
		end

		describe "the deletion should be mutual between both users" do
		
			subject { other_user }
			it { should_not be_friends_with(@user) }
			its(:friends) { should_not include(@user) }
		end
	end
	
end
