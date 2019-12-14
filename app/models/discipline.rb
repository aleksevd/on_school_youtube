class Discipline < ApplicationRecord
  has_many :discipline_courses
  has_many :courses, through: :discipline_courses

  validates :name, presence: true, uniqueness: true
end
