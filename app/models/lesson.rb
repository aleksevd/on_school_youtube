class Lesson < ApplicationRecord
  include Authority::Abilities

  belongs_to :course
  belongs_to :section

  has_many :tinymce_images, as: :owner, dependent: :destroy

  has_many :user_lessons, dependent: :destroy
  has_many :users, through: :user_lessons

  scope :stop_lessons, -> { where(stop_lesson: true) }
  scope :free, -> { where(free: true) }

  validates :name, presence: true
  validates :section_id, presence: true

  mount_uploader :main_image, MainLessonImageUploader

  acts_as_list

  def previous
    return if position == 1

    course.lessons.find_by(position: position - 1)
  end

  def next
    course.lessons.find_by(position: position + 1)
  end
end
