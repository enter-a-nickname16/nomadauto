class AddTaskToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :task, foreign_key: true
  end
end
