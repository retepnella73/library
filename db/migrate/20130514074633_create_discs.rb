class CreateDiscs < ActiveRecord::Migration
  def change
    create_table :discs do |t|
      t.string :title
      t.string :sort_title
      t.integer :release_year
      t.string :toc
      t.string :catalog_number
      t.integer :artist_id
      t.integer :label_id

      t.timestamps
    end
  end
end
