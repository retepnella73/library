class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :number
      t.string :title
      t.string :sort_title
      t.string :mix
      t.integer :duration
      t.integer :disc_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
