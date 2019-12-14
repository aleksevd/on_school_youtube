class Course < ApplicationRecord
  include Authority::Abilities

  belongs_to :teacher

  has_many :discipline_courses, dependent: :destroy
  has_many :disciplines, through: :discipline_courses

  has_many :lessons, dependent: :restrict_with_error
  has_many :sections, dependent: :destroy

  has_many :flows, dependent: :destroy
  has_many :user_courses, dependent: :restrict_with_error
  has_many :users, through: :user_courses

  validates :name, presence: true
  validates :description, presence: true
  validates :disciplines, presence: true

  mount_uploader :main_image, MainCourseImageUploader

  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

  def user_lessons
    UserLesson.joins(:lesson).where(lessons: { course_id: id })
  end

  def current_flow
    flows.active
  end

  def can_be_destroyed?
    !(lessons.exists? || user_courses.exists?)
  end
end
