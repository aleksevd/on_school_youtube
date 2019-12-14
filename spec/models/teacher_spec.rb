require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it { is_expected.to have_many(:courses).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:answers).dependent(:restrict_with_exception) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:description) }
end
