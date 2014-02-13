require 'spec_helper'

describe User do 
	before :each do 
			@user = User.create(:email => 'songyiyang@gmail.com')
		end
	it { should validate_presence_of(:email)}
	describe "associations" do
		it { should have_many :songs}
	end

	describe 'user valid check' do
		
		it 'should have valid email' do
			expect(@user.email).to include("@")
			expect(@user.email).to include(".")
		end
	end
end
