class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	# callback method to downcase the email before saving to user db.
	# Not all adapters use case sensitive indices. I think this
	# includes Heroku.
	before_save { self.email = email.downcase }
	
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
