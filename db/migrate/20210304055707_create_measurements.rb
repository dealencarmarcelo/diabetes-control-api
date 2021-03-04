class CreateMeasurements < ActiveRecord::Migration[6.0]
  def change
    create_table :measurements do |t|
      t.references :user, foreign_key: true
      t.integer :value
      t.integer :status

      t.timestamps
    end
  end
end
