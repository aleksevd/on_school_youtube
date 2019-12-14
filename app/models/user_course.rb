class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :flow

  has_many :user_lessons, dependent: :destroy

  validates :course_id, uniqueness: { scope: :user_id }

  scope :inactive, -> { where(state: :inactive) }
  scope :active, -> { where(state: :active) }
  scope :with_finished_checks, -> { where(state: :checks_finished) }
  scope :with_open_states, -> { where(state: [:active, :checks_finished]) }

  after_create :add_free_lessons

  state_machine initial: :inactive do
    state :inactive
    state :active
    state :checks_finished
    state :finished

    event :activate do
      transition :inactive => :active, if: :can_be_activated?
      transition :inactive => same
    end

    event :finish_checks do
      transition :active => :checks_finished
    end

    event :extend_checks do
      transition :checks_finished => :active
    end

    event :finish do
      transition [:active, :checks_finished] => :finished
    end

    after_transition :inactive => :active, do: :add_first_lessons_batch_to_users
  end

  def in_open_states?
    active? || checks_finished?
  end

  private

  def can_be_activated?
    paid? && flow.active?
  end

  def add_free_lessons
    user.add_lessons(course.lessons.free, self)
  end

  def add_first_lessons_batch_to_users
    first_stop_lesson = course.lessons.stop_lessons.order(:position).first

    lessons = course.lessons
    lessons = lessons.where('position <= ?', first_stop_lesson.position) if first_stop_lesson

    user.add_lessons(lessons, self)
  end
end
