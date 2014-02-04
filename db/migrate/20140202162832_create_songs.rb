class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.text :name
      t.text :artist
      t.text :url
      t.text :genre
      t.integer :duration
      t.references :user, index: true


      t.timestamps
    end
  end
end
