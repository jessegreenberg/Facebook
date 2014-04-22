Feature: Navigating the facebook website

	Secnario: User can visit the profile page
		Given the user is logged in to facebook
			And they are on the newsfeed page
		When they click on the profile tab
		Then they should see their profile page
