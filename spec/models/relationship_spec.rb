require 'spec_helper'

describe Relationship do

	let(:person) { FactoryGirl.create(:user) }
	let(:different_person) { FactoryGirl.create(:user) }
	let(:friendship) { person.relationships.build(friend_b_id: different_person.id) }

	subject { friendship } 
	
	it { should be_valid }	


	describe "friend methods" do

		it { should respond_to(:friend_a) }
		it { should respond_to(:friend_b) }
		its(:friend_a) { should eq person }
		its(:friend_b) { should eq different_person }
	end

	describe "when friend_a id is not present" do
		before { friendship.friend_a_id = nil }
		it { should_not be_valid }
	end

	describe "when friend_b id is not present" do
		before { friendship.friend_b_id = nil }
		it {should_not be_valid }
	end
end
