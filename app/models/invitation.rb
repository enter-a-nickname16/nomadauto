class Invite < ActiveRecord::Base
  belongs_to :user_group
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
end
