# Ruby on Rails Project - - - Facebook

## FOR INSTRUCTORS

Team members: 
Doug Fitzpatrick, Jesse Greenberg, Nick Reynders


## Description: 

The project is a recreation of the Facebook application when it first started in 2004

### Models: 

user.rb
	Validates users' personal information, such as email and password
	It also holds several functions involving relationship control.
	
userpost.rb
	Contains content and a userid.  The user id is used to keep track of
	which user the userpost belongs to.
	
relationship.rb
	Contains the structure of relationships.  There is a friend_a, which is the
	foreign key to the users table, a friend_b which is the id of the friend
	of friend_a, and friendship_status, which keeps track of whether friend_a
	submited a friend reqeust to friend_b, is deciding on an action for a friend
	request from friend_b, or is curently friends with friend_b.  Note that the 
	foreign key restriction on friend_a means that each relationship has two entries
	in the relationship table so that information about a user's friends can be called
	on for each user in the relationship.
	
	
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

* ~~Friend Requests~~

  - ~~need to add 'confirm' or 'deny' button to "friends" page~~
  - ~~format friends page better~~

* Search function

  - ~~https://we.riseup.net/rails/simple-search-tutorial~~
  - ~~search bar area at top of page~~
  - ~~format search correctly~~
  - ~~fix search field return strings~~

* News feed

  - should be simple after Friend Requesting is complete

* Security flaw?

  - feature it!

* Cleanup

## Additional Notes:
	
	All features defined in the project rubric are functional, and stories defined
	through pivotal tracker are implemented.  We did change one thing: user profile pages
	are not exclusively viewable by the users friends.  We wanted to make sure that 
	profile pages were open to any user.  This is how facebook is currently implemented, and
	we wanted to keep this functionality. 
	
	heroku link: facebook-3308.herokuapp.com



