class CreateBunches < ActiveRecord::Migration[6.0]
  def change
    create_table :bunches do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
