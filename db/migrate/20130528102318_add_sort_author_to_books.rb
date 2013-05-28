class AddSortAuthorToBooks < ActiveRecord::Migration
  def change
    add_column :books, :sort_author, :string
  end
end
