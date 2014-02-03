class AddSongidToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :songid, :Integer
  end
end
