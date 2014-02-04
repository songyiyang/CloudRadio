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
  end

  def userlib
    @songs = current_user.songs
  end
  def preference

  end
  def changepreference
    
  end







end
