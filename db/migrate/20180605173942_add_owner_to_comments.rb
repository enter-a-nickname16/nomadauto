class AddOwnerToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :owner, :string
  end
end
