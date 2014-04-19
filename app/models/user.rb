class User < ActiveRecord::Base
	# REGEX to ensure valid email pattern
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	# Create association between userposts
	has_many :userposts
	
	# callback method to downcase the email before saving to user db.
	# Not all adapters use case sensitive indices. I think this
	# includes Heroku.
	before_save { self.email = email.downcase }
	
	# Another callback method to create a user session
	before_create :create_remember_token
	
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	
	#Ruby method to implement all 'virtual' password attributes!
	#Also covers ENTIRE password authentication.
	#To continue with TDD, comment out to understand how it works.
	has_secure_password
	
	#SecureRandom is a module in standard ruby that returns a string of 16 chars.
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	
	#SHA1 is a hashing algorithm 'just in case'.  Faster than BCrypt, more often used, less secure.
	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	# Feed method; This is a preliminary implementation
	# The question mark escapes the input to avoid an SQL injection.
	def newsfeed
		Userpost.where("user_id = ?", id)
	end
	
	
	# The following is not accessable to an outside object.
	private
	
		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end
end
