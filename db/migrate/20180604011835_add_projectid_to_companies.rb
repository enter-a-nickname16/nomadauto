class AddProjectidToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_reference :companies, :project, foreign_key: true
  end
end
