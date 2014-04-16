RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		expect(page).to have_selector('div.alert.alert-error', text: message)
	end
end

def sign_in(user, options={})
	if options[:no_capybara]
		# Sign in when not using Capybara.
		remember_token = User.new_remember_token
		cookies[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.hash(remember_token))
	else
		visit new_user_path
		within(".foo") do
			fill_in "Email",    with: user.email
			fill_in "Password", with: user.password
			click_button "Sign In"
		end
	end
end
