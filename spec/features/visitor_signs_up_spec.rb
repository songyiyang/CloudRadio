require 'spec_helper'

feature 'Visitor signs up' do
	background do
		user = create(:user)
		sign_up(user)
	end
	scenario 'successfully' do
		expect(page).to have_content 'Signed in as bob@example.com'
		expect(page).to have_link 'Sign out'
	end
end
