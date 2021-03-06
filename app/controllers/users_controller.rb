class UsersController < ApplicationController
  skip_before_action :authenticate_user!,  only: [:home]
  include UsersHelper
  # this is home page for non-login user
  def home
    @client = Soundcloud.new(:client_id => 'ae9f52f98895e6a3663870f4de3549a5')
    track_find = Track.find(rand(1..2400))
    track = User.get_track_nonlogin(track_find.track_id, @client)
    genre = track["genre"]
    track_url = track['permalink_url']
    embed_info = @client.get('/oembed', :url => track_url)
    @embed_http = embed_info['html'].split("src=\"")[1].split("\">")[0]
    @duration = track["duration"] / 1000 + 5
    @song = Song.create(:name => track["title"], :genre => genre, :artist => track["user"]["username"], :songid => track["id"], :duration => @duration, :url =>track['permalink_url'])
    if current_user.present?
      redirect_to homepage_path
    end
  end
  
  # this main homepage, play songs automaticly
  def homepage
    @client = Soundcloud.new(:client_id => 'ae9f52f98895e6a3663870f4de3549a5')
    track_genre = User.calculate_genre(current_user, @client)
    track = track_genre[0]
    genre = track_genre[1]
    @embed_http = track_genre[2]
    @duration = track["duration"] / 1000 + 5
    @song = Song.create(:name => track["title"], :genre => genre, :artist => track["user"]["username"], :songid => track["id"], :duration => @duration, :url =>track['permalink_url'])
    current_user.songs << @song
    current_user.save
  end

  # user preference page, can change user's preference
  def userlib
    @genre_array = %w(blues classical country electro folk hiphop jazz metal mixtape pop rock rap)
    genre_add = %w(blues classical country electro folk hiphop jazz metal mixtape pop rock rap)
    if current_user.genre.size < 12
      current_user.genre.each do |genre|
        if @genre_array.include?(genre)
          genre_add.delete(genre)
        end
      end
      genre_add.each do |genre|
        current_user.genre[genre] = 0
      end
      current_user.save
    end
  end

  # can edit user's preference using this method
  def edit
    @genre = params[:genre]
    @act = params[:act]
    if @act == 'increase'
      if current_user[:genre].values.sum <= 95
        current_user.genre[@genre] += 5
      elsif current_user[:genre].values.sum > 95 && current_user[:genre].values.sum < 100
        current_user.genre[@genre] += 100 - current_user[:genre].values.sum
      end
      current_user.save
    elsif @act == 'decrease'
      if current_user[:genre].values.sum >= 5 && current_user.genre[@genre] >= 5
        current_user.genre[@genre] -= 5
      end
      current_user.save
    end
    redirect_to users_userlib_path
  end

  # will show the liked songs from user
  def songsliked
    @songs = current_user.songs
  end

  def about
  end
  
  def recently
    flag = false
    @songs = current_user.songs
    size = @songs.size
    @n = params[:n].to_i
    if @n <= (size - size % 5 )
      if @n == (size - size % 5)
        @n += size % 5
      else
        @n += 5
      end
    end
  end

  # reset user preference
  def reset
    current_user.genre.each do |genre|
      current_user.genre[genre[0]] = 0  if current_user.genre[genre[0]].present?
    end
    current_user.save
    redirect_to users_userlib_path
  end

end
