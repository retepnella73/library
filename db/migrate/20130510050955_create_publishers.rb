class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :sort_name
      t.string :location

      t.timestamps
    end
  end
end
