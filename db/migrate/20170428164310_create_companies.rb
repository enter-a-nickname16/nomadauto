class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :company
      t.string :first_name
      t.string :last_name
      t.integer :phone_number
      t.string :website
      t.string :email

      t.timestamps
    end
  end
end
