class AddFormatToDiscs < ActiveRecord::Migration
  def change
    add_column :discs, :format_id, :integer
  end
end
