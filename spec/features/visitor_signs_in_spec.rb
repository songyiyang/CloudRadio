require 'spec_helper'

feature 'Visitor signs in' do
	background do
		@user = create(:user)
		visit root_path
	end
	scenario 'succesfully' do
		click_on 'Sign In'
		sign_in_as(@user)
	end
end
