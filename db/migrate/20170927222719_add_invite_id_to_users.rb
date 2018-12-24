class AddInviteIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invite_id, :integer
  end
end
