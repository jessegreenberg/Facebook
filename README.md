# Ruby on Rails Project - - - Facebook

Team members: 
Doug Fitzpatrick, Jesse Greenberg, Nick Reynders


## Description: 

The project is a recreation of the Facebook application when it first started in 2004

### Models: 

user.rb
	Validates users' personal information, such as email and password

### Views: 

 - friend_list.html.erb
 		
 	This is the facebook Friend list, it will show a list of the users current friends as well as a list of pending friend reqeusts.

 - friend_search.html.erb

 	This is the Friend Search page. Users can enter search terms (specifically a user's last name) and a list of users with that last name will appear here.  The user can then easily send that user a friend request.

 - login.html.erb

 	This is the default page for Facebook, it allows users to sign on and has a greeting message
		
 - newsfeed.html.erb

 	This is the users Newsfeed. It is a compilation of all posts that the user and his friends have made.  It will be possible for the user to delete his own posts from this page.
	

 - profile_page.html.erb

 	This is the users profile page, it will have all information in a displayable format for the user and the user's friends.

 - profile_preferences.html.erb

	This will be the profile preferences page where users can decide what information they want to display to their friends.

### Controller: 

 - facebook_pages_controller.rb
 - users_controller.rb
 	- Contains default code needed for structure, inherits the data it uses.


##Todo:

- Change root\_\* paths to signin\_\* paths
	- includes changing routes aswell

- Listing 9.16
