class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :text, null: false
      t.string :answer
      t.boolean :shared, null: false, default: true
      t.references :bunch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
