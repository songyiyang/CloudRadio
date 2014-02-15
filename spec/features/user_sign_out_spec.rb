require 'spec_helper'

feature "User signs out" do
	scenario 'successfully' do
		user = create(:user)
		sign_in_as(user)
		expect(page).to_not have_content 'Signed in'
	end
end
