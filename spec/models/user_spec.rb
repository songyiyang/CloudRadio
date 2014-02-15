require 'spec_helper'

describe User do 
	it { should validate_presence_of(:email)}
	describe "associations" do
		it { should have_many :songs}
	end
end
