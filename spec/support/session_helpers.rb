module SessionHelpers
	def sign_in_as(user)
		visit root_path
		click_on "Sign In"
		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Sign in'
	end

	def sign_up(user)
		visit root_path
		click_on 'Sign Up'
		fill_in 'Email address', with: user.email
		fill_in 'Password', with: user.password
		fill_in 'Password confirmation', with: user.password
		click_button 'Sign up'
	end
end
