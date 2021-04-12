class CreateFrames < ActiveRecord::Migration[6.0]
  def change
    create_table :frames do |t|
      t.references :player, null: false, foreign_key: {on_delete: :cascade}
      t.integer :frame #silly tautological naming 
      t.integer :knocked_pins
      t.integer :turn #should have named it shots

      t.timestamps
    end
  end
end
