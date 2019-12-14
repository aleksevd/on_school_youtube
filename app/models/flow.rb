class Flow < ApplicationRecord
  include Authority::Abilities

  belongs_to :course

  has_many :user_courses, dependent: :restrict_with_error

  scope :in_future, -> { where(state: :in_future) }
  scope :active, -> { where(state: :active) }
  scope :checks_finished, -> { where(state: :checks_finished) }
  scope :finished, -> { where(state: :finished) }
  scope :not_finished, -> { where.not(state: :finished) }

  validates :starts_at, presence: true
  validates :checks_finish_at, presence: true
  validates :finishes_at, presence: true
  validates :price, presence: true

  validate :not_crossing_other_flow_period
  validate :checks_finish_at_between_starts_at_and_finishs_at

  after_initialize :set_default_values

  state_machine initial: :in_future do
    state :in_future do
      validates :starts_at, in_future: true
      validates :checks_finish_at, in_future: true
      validates :finishes_at, in_future: true
    end

    state :active
    state :checks_finished
    state :finished

    event :start do
      transition :in_future => :active
    end

    event :finish_checks do
      transition :active => :checks_finished
    end

    event :finish do
      transition :checks_finished => :finished
    end

    after_transition :in_future => :active, do: :activate_accesses
    after_transition :active => :checks_finished, do: :finish_user_courses_checks
    after_transition :checks_finished => :finished, do: :finish_user_courses
  end

  def self.change_states
    checks_finished.where('finishes_at < ?', Time.zone.now).map(&:finish)
    active.where('checks_finish_at < ?', Time.zone.now).map(&:finish_checks)
    in_future.where('starts_at < ?', Time.zone.now).map(&:start)
  end

  private

  def activate_accesses
    user_courses.map(&:activate)
  end

  def finish_user_courses_checks
    user_courses.active.map(&:finish_checks)
  end

  def finish_user_courses
    user_courses.with_open_states.map(&:finish)
  end

  def not_crossing_other_flow_period
    if course && starts_at && finishes_at && crossing_other_flow_period?
      errors.add(:starts_at, 'не может пересекаться с датами существующего потока')
      errors.add(:finishes_at, 'не может пересекаться с датами существующего потока')
    end
  end

  def crossing_other_flow_period?
    !not_finished_flows.all? do |t|
      (starts_at < t.starts_at && finishes_at < t.starts_at) ||
        (starts_at > t.finishes_at && finishes_at > t.finishes_at)
    end
  end

  def checks_finish_at_between_starts_at_and_finishs_at
    return unless starts_at && checks_finish_at && finishes_at

    if checks_finish_at <= starts_at || checks_finish_at > finishes_at
      errors.add(:checks_finish_at, 'не может быть раньше начала или позже конца потока')
    end
  end

  def not_finished_flows
    @not_finished_flows ||= course.flows.where.not(id: id).not_finished.select(:starts_at, :finishes_at)
  end

  def set_default_values
    self.starts_at ||= Time.zone.now if has_attribute?(:starts_at)
    self.checks_finish_at ||= Time.zone.now if has_attribute?(:checks_finish_at)
    self.finishes_at ||= Time.zone.now if has_attribute?(:checks_finish_at)
  end
end
