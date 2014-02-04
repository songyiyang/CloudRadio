class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:homepage]

  include SongsHelper
  def like
    @song = Song.find(params[:id])
    msg = "You've already liked this song!"
    if !current_user.flagged?(@song)
      current_user.flag(@song, 'like')
      if current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre].values.sum <= 90
        current_user[:genre]["#{@song[:genre]}"] += 10
      elsif current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre].values.sum < 100
        current_user[:genre]["#{@song[:genre]}"] += (100 - current_user[:genre].values.sum)
      elsif current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre].values.sum == 0
        current_user[:genre]["#{@song[:genre]}"] = 10
      end
      current_user.save
      msg = "You now like this song"
    end
    redirect_to song_path, :notice => msg
  end

  def unlike
    @song = Song.find(params[:id])
    msg = "You've already disliked this song!"
    flag = false
    if current_user.flagged?(@song)
      current_user.unflag(@song)
      dislike_decrease(current_user, @song)
      msg = "You now don't like this song"
      flag = true
    elsif flag == false
        dislike_decrease(current_user, @song)
    end
    
    redirect_to song_path, :notice => msg
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
