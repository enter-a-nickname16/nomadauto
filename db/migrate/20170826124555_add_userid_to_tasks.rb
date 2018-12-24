class AddUseridToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :user_id, :integer
  end
end
