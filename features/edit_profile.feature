Feature: Changing Personal Information

	Scenario: User successfully updates personal information
		Given the user is logged in to facebook
			And they click on the profile preferences link
		When the user enters new information in the form
			And the user presses the save changes button
		Then the user should see their profile page with updated content
			And the user should be notified of successful update
		
			
	Scenario: User enters invalid information
		Given the user is logged in to facebook
			And they click on the profile preferences link
		When the user enters invalid information
			And the user presses the save changes button
		Then the user should see the profile preferences page
			And the user should be notified of an unsuccessful update
