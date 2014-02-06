class StaticPagesController < ApplicationController
	skip_before_action :authenticate_user!,  only: [:home]

	def home
		if current_user.present?
			redirect_to homepage_path
		end
	end
end
