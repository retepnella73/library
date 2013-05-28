class AddBindingToBooks < ActiveRecord::Migration
  def change
    add_column :books, :binding, :string
  end
end
