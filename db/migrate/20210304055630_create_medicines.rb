class CreateMedicines < ActiveRecord::Migration[6.0]
  def change
    create_table :medicines do |t|
      t.string :name
      t.integer :content
      t.string :unit

      t.references :brand, foreign_key: true
      t.references :medicine_type, foreign_key: true

      t.timestamps
    end
  end
end
