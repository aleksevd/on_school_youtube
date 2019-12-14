require 'rails_helper'

RSpec.describe TinymceImage, type: :model do
  it { is_expected.to belong_to(:owner) }
end
