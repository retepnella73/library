class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :first_name
      t.string :pre_name

      t.timestamps
    end
  end
end
