Feature: Creating a Facebook Post

	Scenario: Successful User Post
		Given the user is logged in to facebook
			And the user visits their profile page
		When the user enters content in the post box
			And they click the share button
		Then they should see their post on their profile page
			And they should see their post on the Newsfeed
