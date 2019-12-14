require 'rails_helper'

RSpec.describe UserLesson, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:lesson) }
  it { is_expected.to belong_to(:user_course) }

  it { is_expected.to have_many(:answers).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:lesson) }
  it { is_expected.to validate_presence_of(:user_course) }
end
