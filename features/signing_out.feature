
Feature: Signing Out of Facebook

		Scenario: User can sign out of facebook session
			Given the user is logged in to facebook
			When they click on the Sign Out link
			Then they should be logged out of facebook
				And they should see the sign in page

		
