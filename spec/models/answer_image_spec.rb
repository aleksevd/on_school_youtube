require 'rails_helper'

RSpec.describe AnswerImage, type: :model do
  it { is_expected.to belong_to(:answer) }

  it { is_expected.to validate_presence_of(:answer) }
end
