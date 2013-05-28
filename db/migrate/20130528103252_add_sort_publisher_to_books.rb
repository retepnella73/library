class AddSortPublisherToBooks < ActiveRecord::Migration
  def change
    add_column :books, :sort_publisher, :string
  end
end
