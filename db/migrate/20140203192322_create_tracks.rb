class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.text :track_id
      t.text :genre
      t.integer :duration

      t.timestamps
    end
  end
end
