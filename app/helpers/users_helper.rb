module UsersHelper

	def calculate_genre (user, client)
		track_genre = ""
		track = client.get('/tracks', :limit => 0)
		@n = Random.rand(0..11)
		#genre_array = %w(ambient bluegrass blues classical country dance disco dubstep electro electronic folk hiphop house indierock jazz latin metal metalcore mixtape piano pop punk rap reggae rock soul techno trance trap world audiobooks business comedy entertainment learning science sports storytelling)
		genre_array = %w(blues classical country electro folk hiphop jazz metal mixtape pop rock rap)
		sum = current_user[:genre].values.sum
		if sum != 0 && sum < 12
			user[:genre].each do |genre|
				track += @client.get('/tracks', :limit => genre[1], :tags => genre[0])
			end
		elsif sum >= 12
			user[:genre].each do |genre|
				count = 12 * genre[1] / sum
				track += @client.get('/tracks', :limit => count, :tags => genre[0])
			end
		end
		if track.size < 12
			count = 12 - track.size
			for i in 1..count
				track += client.get('/tracks', :limit => 1, :tags => genre_array[Random.rand(0..11)])
			end
		end
		track_sound = track[@n]
    tag = track_sound[:tag_list]
    tag.split.each do |tag|
    	if genre_array.include?(tag.downcase)
    		track_genre = tag.downcase
    	end
    end
    [track_sound, track_genre, tag]
	end
end
