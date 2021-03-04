class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :surname
      t.string :email
      t.string :password_digest
      t.string :phone
      t.datetime :birth_date
      t.datetime :diabetes_discovery_date

      t.timestamps
    end
  end
end
