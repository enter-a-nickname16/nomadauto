class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.string :company
      t.string :status
      t.integer :value

      t.timestamps
    end
  end
end
