module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
    self.current_user = user
  end
	# checks to see if there is a current user in the session.
  def signed_in?
    !current_user.nil?
  end

	# The current_user=() allows for easy function definition for simple assignment.
  def current_user=(user)
    @current_user = user
  end

	# ||= is a smoothe way to set the @current_user only if the @current_user is nil.
  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
