class User < ActiveRecord::Base
	has_many :songs
	make_flagger
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  serialize :genre, Hash
  serialize :disliked, Hash



  def self.calculate_genre (user, client)
		# init some parameters
		track_id = []
		id_array = user.get_id_array(user)
		sum = user[:genre].values.sum
		array = []
		# Handle the user preference
		if sum != 0 && sum <= 100
			user[:genre].each do |genre|
				track_id += user.get_track(genre[1], genre[0], client, user)
			end
		end

		if track_id.size < 100
			size_count = 100 - track_id.size
			size_count.times do
				array << rand(1..2400)
			end
			track_finds = Track.find(array)
			track_finds.each do |track_find|
				if track_find.duration < 500000 && user.disliked[track_find.track_id] != true
					track_id << track_find.track_id
				end
			end
		end

		# End handle and Prepare for output
		track_sound = user.get_track_handled(track_id, client)
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
		array = []
		genre_array = %w(blues classical country electro folk hiphop jazz metal mixtape pop rock rap)
		loc = genre_array.index(genre) + 1

		count.times do
			array << rand(((loc-1)*200+1)..((loc)*200))
		end
			track_find = Track.find(array)
		track_find.each do |track_find|
			if track_find.duration < 500000 && user.disliked[track_find.track_id] != true
				track_id << track_find.track_id
			end
		end
		track_id
	end

	# this method will return a track from soundcloud 
	def get_track_handled(track_id, client)

		track = track_id[rand(0..track_id.size)]
		begin
			track_sound = client.get("/tracks/#{track}")
		rescue
			track_sound = get_track_handled(track_id, client)
		end
		track_sound
	end

	# this method is for non-login user
	def self.get_track_nonlogin(track_id, client)
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
