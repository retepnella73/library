class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works, :id => false  do |t|
      t.integer :author_id
      t.integer :book_id
      t.timestamps
    end
  end
end
