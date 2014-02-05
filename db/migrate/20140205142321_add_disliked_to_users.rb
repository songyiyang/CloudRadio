class AddDislikedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :disliked, :text
  end
end
