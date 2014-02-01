class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :song_id
      t.text :genre
      t.text :url

      t.timestamps
    end
  end
end
