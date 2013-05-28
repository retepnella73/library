class RenameFormatTableToDiscFormatTable < ActiveRecord::Migration
  def change
    create_table :disc_formats do |t|
      t.string :name

      t.timestamps
    end
  end
end
