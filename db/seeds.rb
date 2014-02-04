
client = Soundcloud.new(:client_id => 'ae9f52f98895e6a3663870f4de3549a5')

genre_array = %w(blues classical country electro folk hiphop jazz metal mixtape pop rock rap)
genre_array.each do |genre|
	tracks = client.get('/tracks', :limit => 200, :tags => genre)
	for i in 0..199
		Track.create(:track_id => tracks[i]["id"], :genre => genre, :duration => tracks[i]["duration"])
	end
end
