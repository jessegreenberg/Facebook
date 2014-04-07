FactoryGirl.define do
	factory :user do
		name "Jesse Greenberg"
		email "jesse.greenberg@colorado.edu"
		password "foobar"
		password_confirmation "foobar"
	end
end
