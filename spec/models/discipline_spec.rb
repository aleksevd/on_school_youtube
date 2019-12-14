require 'rails_helper'

RSpec.describe Discipline, type: :model do
  it { is_expected.to have_many(:discipline_courses) }
  it { is_expected.to have_many(:courses).through(:discipline_courses) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
