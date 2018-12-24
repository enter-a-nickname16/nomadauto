class AddDealToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :deal, foreign_key: true
  end
end
