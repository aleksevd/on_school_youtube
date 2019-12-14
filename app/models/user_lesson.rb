class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  belongs_to :user_course

  has_many :answers, dependent: :destroy

  scope :completed, -> { where(state: :completed) }

  validates :lesson_id, uniqueness: { scope: :user_id }

  state_machine initial: :active do
    state :active
    state :checking
    state :rejected
    state :completed

    event :give_answer do
      transition [:active, :rejected, :checking] => :checking
    end

    event :give_teacher_answer do
      transition :checking => :rejected
      transition :completed => :completed
    end

    event :reject do
      transition [:checking, :rejected] => :rejected
    end

    event :complete do
      transition any => :completed
    end

    event :return do
      transition :completed => :rejected
    end
  end
end
