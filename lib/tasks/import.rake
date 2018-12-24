require 'csv'

namespace :import do

  desc "Import tasks from csv"
  task tasks: :environment do
    filename = File.join Rails.root, "tasks.csv"
    counter = 0

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      task = Task.assign_from_row(row)
      if task.save
        counter += 1
      else
        puts "#{task.title} - #{task.errors.full_messages.join(", ")}"
      end
    end

    puts "Imported #{counter} tasks"

  end
end
