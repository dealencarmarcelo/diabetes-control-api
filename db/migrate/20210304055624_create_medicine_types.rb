class CreateMedicineTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :medicine_types do |t|
      t.string :name
      t.string :kind

      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
