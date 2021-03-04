class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :user, foreign_key: true
      t.references :stockable, polymorphic: true
      t.integer :quantity

      t.timestamps
    end
  end
end
