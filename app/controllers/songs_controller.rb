class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:homepage]


  def like
    @song = Song.find(params[:id])

    if current_user.flagged?(@song)
      current_user.unflag(@song)
      if current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre]["#{@song[:genre]}"] > 0
        current_user[:genre]["#{@song[:genre]}"] -= 1
      else 
        current_user[:genre]["#{@song[:genre]}"] = 0
      end
      current_user.save
      msg = "You now don't like this song"
    else
      current_user.flag(@song, 'like')
      if current_user[:genre]["#{@song[:genre]}"].present?
        current_user[:genre]["#{@song[:genre]}"] += 1
      else 
        current_user[:genre]["#{@song[:genre]}"] = 1
      end
      current_user.save
      msg = "You now like this song"
    end
    redirect_to song_path, :notice => msg
  end

  def unlike
      @song = Song.find(params[:id])
      if current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre]["#{@song[:genre]}"] > 0
        current_user[:genre]["#{@song[:genre]}"] -= 1
      else 
        current_user[:genre]["#{@song[:genre]}"] = 0
      end
      current_user.save
      redirect_to song_path
    end

  def show

    @song = Song.find(params[:id])

  end

  def index
    @songs = Song.all
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
