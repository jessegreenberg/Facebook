Feature: Creating a Facebook Post

	Scenario: Successful User Post
		Given a user visits their profile page
		When they enter a new status in the content box
		And they click the share button
		Then they should see their post on their profile page
		And they should see their post on the Newsfeed
