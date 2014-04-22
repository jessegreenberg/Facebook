Feature: Creating a Facebook Account

	Scenario: Unsuccessful Account Creation
		Given a user visits the signin page
		When they submit an invalid name
		Then they should see the signin page
		
		Given a user visits the signin page
		When they submit an invalid email
		Then they should see the signin page
		
		Given a user visits the signin page
		When they submit a non-matching password
		Then they should see the signin page
		
	Scenario: Successful Account Creation
		Given a user visits the signin page
		When they submit valid sign up information
		Then they should see the profile page
