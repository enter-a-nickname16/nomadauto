class AddUseridToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :user_id, :integer
  end
end
