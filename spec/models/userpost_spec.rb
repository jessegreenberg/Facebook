require 'spec_helper'

describe Userpost do
	
	
	let(:user) { FactoryGirl.create(:user) }
	before do
		# The association 'build' method returns a new micropost object,
		# automatically assigning the user's ID.
		@userpost = user.userposts.build(content: "Lorem ipsum")
	end
	
	subject { @userpost }
	
	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	
	# Test the userpost/user association.  More detailed association
	# testing in user model spec.
	it { should respond_to(:user) }
	its(:user) { should eq user }
	
	it { should be_valid }
	
	describe "when user_id is not present" do
		before { @userpost.user_id = nil }
		it { should_not be_valid }
	end

	describe "when user id is not present" do
		before { @userpost.user_id = nil }
		it { should_not be_valid }	
	end

	describe "with blank content" do
		before { @userpost.content = "" }
		it { should_not be_valid }
	end
end
