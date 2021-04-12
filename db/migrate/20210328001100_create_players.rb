class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.references :session, null: false, foreign_key: {on_delete: :cascade}
      t.integer :score #dont need this
      t.boolean :session_winner #probably this too

      t.timestamps
    end
  end
end
