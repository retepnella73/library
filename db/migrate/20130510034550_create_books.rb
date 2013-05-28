class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :sort_title
      t.string :ISBN
      t.integer :year
      t.integer :first_published
      t.string :edition
      t.integer :page_count
      t.integer :width
      t.integer :height
      t.integer :thickness
      t.text :details

      t.timestamps
    end
  end
end
