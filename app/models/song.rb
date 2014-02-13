class Song < ActiveRecord::Base
	belongs_to :user
	make_flaggable

	def self.dislike_decrease(current_user, song)
		if current_user[:genre]["#{song[:genre]}"].present? && current_user[:genre]["#{song[:genre]}"] >= 10
      current_user[:genre]["#{song[:genre]}"] -= 10
    elsif current_user[:genre]["#{song[:genre]}"].present? && current_user[:genre]["#{song[:genre]}"] <= 10 && current_user[:genre]["#{song[:genre]}"] > 0
      current_user[:genre]["#{song[:genre]}"] = 0
    end
    current_user.save
	end
end
