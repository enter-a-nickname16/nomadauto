class Project < ApplicationRecord
  belongs_to :user
  #validates :title, :presence => true, :length => { :minimum => 5 }

  has_many :companies, dependent: :destroy
  has_many :deals, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :invites, dependent: :destroy
  accepts_nested_attributes_for :tasks

end
