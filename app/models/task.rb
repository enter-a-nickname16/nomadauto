class Task < ApplicationRecord

  belongs_to :user
  belongs_to :project

  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  def self.assign_from_row(row)
      task = Task.where(project_id: row[:project_id],
                        title: row[:title],
                        owner: row[:owner],
                        status: row[:status],
                        priority: row[:priority],
                        description: row[:description]).first_or_initialize
      task
  end



  def self.import(file)
    counter = 0
    CSV.foreach(file.pathmap, headers: true, header_converters: :symbol) do |row|
      task = Task.assign_from_row(row)
      if task.save
        counter += 1
      else
        puts "#{task.title} - #{task.errors.full_messages.join(", ")}"
      end
    end
    counter
  end

end
