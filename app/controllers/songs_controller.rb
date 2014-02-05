class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:homepage]

  include SongsHelper
  # this method will handle the like button
  def like
    @song = Song.find(params[:id])
    msg = "You've already liked this song!"
    if !current_user.flagged?(@song)
      current_user.flag(@song, 'like')
      if current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre].values.sum <= 90
        current_user[:genre]["#{@song[:genre]}"] += 10
      elsif current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre].values.sum < 100
        current_user[:genre]["#{@song[:genre]}"] += (100 - current_user[:genre].values.sum)
      elsif !current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre].values.sum <= 90
        current_user[:genre]["#{@song[:genre]}"] = 10
      elsif !current_user[:genre]["#{@song[:genre]}"].present? && current_user[:genre].values.sum < 100
        current_user[:genre]["#{@song[:genre]}"] = (100 - current_user[:genre].values.sum)
      end
      current_user.save
      msg = "You now like this song!"
    end
    redirect_to song_path, :notice => msg
  end

  # this method will handle the unlike button
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
    current_user.disliked[@song.songid.to_s] = true
    current_user.save
    redirect_to homepage_path
  end

  # will show the song after click like or unlike button
  def show
    @song = Song.find(params[:id])
  end

end
