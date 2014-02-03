module UsersHelper

	def calculate_genre (user, client)
		track_genre = ""
		track = client.get('/tracks', :limit => 0)
		@n = Random.rand(0..11)
		#genre_array = %w(ambient bluegrass blues classical country dance disco dubstep electro electronic folk hiphop house indierock jazz latin metal metalcore mixtape piano pop punk rap reggae rock soul techno trance trap world audiobooks business comedy entertainment learning science sports storytelling)
		genre_array = %w(blues classical country electro folk hiphop jazz metal mixtape pop rock rap)
		id_array = []
		current_user.songs.each do |song|
			id_array << song.songid
		end
		sum = current_user[:genre].values.sum
		if sum != 0 && sum < 12
			user[:genre].each do |genre|
				tracks = @client.get('/tracks', :limit => 50, :tags => genre[0])
				i = 0
				count = 0
				while count < genre[1]
					if id_array.include?(tracks[i]["id"])
						i += 1
					else track << tracks[i]
						i += 1
						count += 1
					end
				end
			end
		elsif sum >= 12
			user[:genre].each do |genre|
				count_size = 12 * genre[1] / sum
				tracks = @client.get('/tracks', :limit => 40, :tags => genre[0])
				i = 0
				count = 0
				while count < count_size
					if id_array.include?(tracks[i]["id"])
						i += 1
					else track << tracks[i]
						i += 1
						count += 1
					end
				end
			end
		end

		if track.size < 12
			size_count = 12 - track.size
			tracks = client.get('/tracks', :limit => 100, :tags => genre_array[Random.rand(0..11)])
			i = 0
			count = 0
			while count < size_count
				if id_array.include?(tracks[i]["id"])
					i += 1
				else track << tracks[i]
					i += 1
					count += 1
				end
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
