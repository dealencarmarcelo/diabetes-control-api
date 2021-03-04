class CreateConsumptions < ActiveRecord::Migration[6.0]
  def change
    create_table :consumptions do |t|
      t.references :stock, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
