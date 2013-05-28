class AddArtistSortToDiscs < ActiveRecord::Migration
  def change
    add_column :discs, :sort_artist, :string
  end
end
