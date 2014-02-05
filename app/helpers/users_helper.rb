module UsersHelper

	def calculate_genre (user, client)
		# init some parameters
		track_id = []
		id_array = get_id_array(user)
		sum = user[:genre].values.sum
	
		# Handle the user preference
		if sum != 0 && sum <= 100
			user[:genre].each do |genre|
				track_id += get_track(genre[1], genre[0], client, user)
			end
		end
		if track_id.size < 100
			size_count = 100 - track_id.size
			count = 0
			while count < size_count
				track_find = Track.find(rand(1..2400))
				if track_find.duration < 500000 && user.disliked[track_find.track_id] != true
					track_id << track_find.track_id
					count += 1
				end
			end
		end

		# End handle and Prepare for output
		track_sound = get_track_handled(track_id, client)
    track_genre = Track.find_by_track_id(track_sound["id"].to_s)["genre"]
    
    # get embed information
    track_url = track_sound['permalink_url']
    embed_info = client.get('/oembed', :url => track_url)
    embed_http = embed_info['html'].split("src=\"")[1].split("\">")[0]
    # The return value
    [track_sound, track_genre, embed_http]
	end

	# this method will return a series of track id within an array for certain genre
	def get_track(count, genre, client, user)
		track_id = []
		genre_array = %w(blues classical country electro folk hiphop jazz metal mixtape pop rock rap)
		loc = genre_array.index(genre) + 1
		count_count = 0
		while count_count < count
			track_find = Track.find(rand(((loc-1)*200+1)..((loc)*200)))
			if track_find.duration < 500000 && user.disliked[track_find.track_id] != true
				track_id << track_find.track_id
				count_count += 1
			end
		end
		track_id
	end

	# this method will return a track from soundcloud 
	def get_track_handled(track_id, client)
		track = track_id[rand(0..99)]
		begin
			track_sound = client.get("/tracks/#{track}")
		rescue
			track_sound = get_track_handled(track_id, client)
		end
		track_sound
	end

	# this method is for non-login user
	def get_track_nonlogin(track_id, client)
		begin
			track_sound = client.get("/tracks/#{track_id}")
		rescue
			track_sound = get_track_handled(track_id, client)
		end
		track_sound
	end

	# this method will return array of user song id
	def get_id_array(user)
		id_array = []
		user.songs.each do |song|
			id_array << song.songid
		end
		id_array
	end
end
