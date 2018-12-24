class AddSubdomainToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :subdomain, :string
  end
end
