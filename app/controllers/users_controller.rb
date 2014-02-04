class UsersController < ApplicationController
  include UsersHelper

  def show
  end

  def index
  end
  
  def homepage
    @client = Soundcloud.new(:client_id => 'ae9f52f98895e6a3663870f4de3549a5')
    track_genre = calculate_genre(current_user, @client)
    track = track_genre[0]
    genre = track_genre[1]
    @embed_http = track_genre[2]
    @duration = track["duration"] / 1000 + 5
    @song = Song.create(:name => track["title"], :genre => genre, :artist => track["user"]["username"], :songid => track["id"], :duration => @duration, :url =>track['permalink_url'])
    current_user.songs << @song
    current_user.save
    @songs = Song.all
  end

  def userlib
    @songs = current_user.songs
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

  def preference

  end
  def changepreference
    
  end

end
