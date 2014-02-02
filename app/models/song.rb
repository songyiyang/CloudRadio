class Song < ActiveRecord::Base
	belongs_to :user
	make_flaggable
end
