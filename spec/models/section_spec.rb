require 'rails_helper'

RSpec.describe Section, type: :model do
  it { is_expected.to belong_to(:course) }
  it { is_expected.to have_many(:lessons).dependent(:restrict_with_error) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:course) }
end
