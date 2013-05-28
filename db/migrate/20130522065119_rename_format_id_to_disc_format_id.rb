class RenameFormatIdToDiscFormatId < ActiveRecord::Migration
  def up
    change_table :discs do |t|
      t.rename(:format_id, :disc_format_id)
    end  
  end

  def down
    change_table :discs do |t|
      rename(:format_id, :disc_format_id)
    end  
  end
end
