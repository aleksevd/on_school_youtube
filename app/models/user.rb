class User < ApplicationRecord
  include Authority::UserAbilities

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_lessons, dependent: :destroy
  has_many :lessons, through: :user_lessons
  has_many :answers, as: :owner, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  mount_uploader :avatar, UserAvatarUploader

  def add_course(flow)
    user_courses.where(course_id: flow.course_id, flow: flow).first_or_create!
  end

  def add_lesson(lesson, user_course)
    user_lessons.where(lesson: lesson, user_course: user_course).first_or_create!
  end

  def add_lessons(lessons, user_course)
    lessons.each do |lesson|
      add_lesson(lesson, user_course)
    end
  end

  def user_lesson_for(lesson)
    user_lessons.where(lesson: lesson).first
  end
end
