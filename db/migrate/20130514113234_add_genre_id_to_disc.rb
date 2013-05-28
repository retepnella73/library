class AddGenreIdToDisc < ActiveRecord::Migration
  def change
    add_column :discs, :genre_id, :integer
  end
end
