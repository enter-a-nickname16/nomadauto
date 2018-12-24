class Invite < ActiveRecord::Base
  belongs_to :user_group
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User', optional: true
  belongs_to :project
  has_many :users

  before_save :check_user_existence

  before_create :generate_token

  def generate_token
     self.token = Digest::SHA1.hexdigest([self.user_group_id, Time.now, rand].join)
  end

  def new_user_invite
    InviteMailer.new_user_invite(self).deliver_now
  end

  def check_user_existence
    recipient = User.find_by_email(email)
   if recipient
      self.recipient_id = recipient.id
   end
  end
  private


end
