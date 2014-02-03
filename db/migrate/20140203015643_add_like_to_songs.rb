class AddLikeToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :like, :boolean
  end
end
