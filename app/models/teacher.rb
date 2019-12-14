class Teacher < ApplicationRecord
  has_many :courses, dependent: :restrict_with_exception
  has_many :answers, as: :owner, dependent: :restrict_with_exception

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, presence: true

  mount_uploader :avatar, TeacherAvatarUploader
end
