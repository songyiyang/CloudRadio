module SongsHelper
	def toggle_like_button(song, user)
		link_to raw("<span class=\"glyphicon glyphicon-heart\"> LikeIt! </span>"), like_song_path(song), class: "btn btn-default btn-lg", :onclick => "window.open(this.href, 'create_company',  'width=500,height=300');return false;"
	end
	
	def toggle_unlike_button(song, user)
		link_to raw("<span class=\"glyphicon glyphicon-trash\"> ThrowAway...</span>"), unlike_song_path(song), class: "btn btn-default btn-lg"
	end

	def toggle_like_button_in_show(song, user)
		if user.flagged?(song)
			link_to "Unlike", unlike_song_path(song)
		else
			link_to "Like", like_song_path(song)
		end
	end

	
end
