class DropUserIdAddOwnerToComments < ActiveRecord::Migration[5.0]
  def up
    remove_column :comments, :user_id
  end
end
