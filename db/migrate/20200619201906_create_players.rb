class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :uuid
      t.references :game, null: false, foreign_key: true
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
