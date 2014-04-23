Feature: Navigating the facebook website

	Scenario: User can visit the profile page
		Given the user is logged in to facebook
			And they are on the newsfeed page
		When they click on the profile tab
		Then they should see their profile page

	Scenario: User can visit the newsfeed page
		Given the user is logged in to facebook
			And they are on the profile page
		When they click on the newsfeed tab
		Then they should see the newsfeed
		
	Scenario: User can see a list of his friends
		Given the user is logged in to facebook
			And the user has friends
			And they are on the profile page
		When they click on the friends link
		Then they should see a list of their friends

	Scenario: User can go to the profile preferences page
		Given the user is logged in to facebook
			And they are on the profile page
		When they click on the profile preferences link
		Then they should see a form for changing information
