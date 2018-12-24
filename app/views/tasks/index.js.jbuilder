json.array!(@tasks) do |task|
  json.extract! task, :id, :status, :timestamp
  json.url project_tasks_path(task, format: :json)
end
