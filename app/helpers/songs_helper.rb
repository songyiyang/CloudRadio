	module SongsHelper
	def toggle_like_button(song, user)
		link_to "Like", like_song_path(song), :target => "_blank", :popup => ['dialog name','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes']
		
	end
	
	def toggle_unlike_button(song, user)
		link_to "Unlike", unlike_song_path(song), :target => "_blank", :popup => ['dialog name','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes']
	end

	def toggle_like_button_in_show(song, user)
		if user.flagged?(song)
			link_to "Unlike", unlike_song_path(song)
		else
			link_to "Like", like_song_path(song)
		end
	end
end
