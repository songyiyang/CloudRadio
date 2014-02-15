require 'spec_helper'

feature 'User have valid email' do
	scenario 'successfully' do
		user = create(:user)
		expect(user.email).to have_content(/@.*./)
	end
end
