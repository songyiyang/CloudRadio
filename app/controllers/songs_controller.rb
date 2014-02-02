class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:homepage]


  def like
    @song = Song.first

    if current_user.flagged?(@song)
      current_user.unflag(@song)
      msg = "You now don't like this song"
    else
      current_user.flag(@song, 'like')
      msg = "You now like this song"
    end

    redirect_to song_path, :notice => msg
  end

  def show

    @song = Song.first

  end

  def index
    current_user = User.first
  end

  def new
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def create
  end
end
