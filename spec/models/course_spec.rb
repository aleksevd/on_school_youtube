require 'rails_helper'

RSpec.describe Course, type: :model do
  it { is_expected.to belong_to(:teacher) }
  it { is_expected.to have_many(:discipline_courses) }
  it { is_expected.to have_many(:disciplines).through(:discipline_courses) }
  it { is_expected.to have_many(:lessons).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:sections).dependent(:destroy) }
  it { is_expected.to have_many(:user_courses) }
  it { is_expected.to have_many(:users).through(:user_courses) }
  it { is_expected.to have_many(:flows) }

  it { is_expected.to validate_presence_of(:teacher) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:disciplines) }
end
