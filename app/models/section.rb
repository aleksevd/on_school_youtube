class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons, dependent: :restrict_with_error

  validates :name, presence: true
  validates :description, presence: true

  acts_as_list
end
