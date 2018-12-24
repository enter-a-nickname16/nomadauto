class List < ApplicationRecord
  belongs_to :user
  belongs_to :project

  acts_as_list

  has_many :cards, ->{ order(postition: :asc) }, dependent: :destroy

  scope :sorted, ->{ order(position: :asc) }

  validates :new, presence: :true
end
