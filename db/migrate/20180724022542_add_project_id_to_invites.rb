class AddProjectIdToInvites < ActiveRecord::Migration[5.0]
  def change
    add_reference :invites, :project, foreign_key: true
  end
end
