class AddCoverToDisc < ActiveRecord::Migration
  def change
    add_column :discs, :cover, :string
  end
end
