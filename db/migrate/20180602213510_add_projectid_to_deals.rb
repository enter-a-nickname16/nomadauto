class AddProjectidToDeals < ActiveRecord::Migration[5.0]
  def change
    add_reference :deals, :project, foreign_key: true
  end
end
