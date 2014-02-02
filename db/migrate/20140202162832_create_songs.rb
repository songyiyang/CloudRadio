class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.text :name
      t.text :artist
      t.text :genre
      t.references :user, index: true
    end
  end
end
