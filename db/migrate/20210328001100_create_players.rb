class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.references :session, null: false, foreign_key: true
      t.integer :score
      t.boolean :session_winner

      t.timestamps
    end
  end
end
