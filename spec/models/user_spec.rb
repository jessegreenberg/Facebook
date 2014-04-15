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
	
	# Userpost association validation ADMIN GETS ADDED LATER
	## it { should respond_to(:admin) }
	it { should respond_to(:userposts) }
	
	#existence validation
	it { should be_valid }
	
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
	
end
