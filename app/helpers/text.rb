
def get_track(client)
	begin
		track = client.get("/tracks/#{rand(10000000..99999999)}")
	rescue
		track = get_track(client)
	end
	track
end

def find_genre(client, genre)
	track = get_track(client)
	if track[:genre].present? && track[:genre] == genre
		return track
	else
		find_genre(client, genre)
	end
end
