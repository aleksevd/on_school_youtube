require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { is_expected.to belong_to(:course) }
  it { is_expected.to belong_to(:section) }
  it { is_expected.to have_many(:tinymce_images).dependent(:destroy) }
  it { is_expected.to have_many(:user_lessons).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:user_lessons) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:section_id) }
  it { is_expected.to validate_presence_of(:section) }
  it { is_expected.to validate_presence_of(:course) }

  context 'navigation' do
    let(:course) { insert(:course) }
    let!(:lesson1) { insert(:lesson, course: course, position: 1) }
    let!(:lesson2) { insert(:lesson, course: course, position: 2) }

    describe '#previous' do
      it 'should return nil for first lesson and previous lesson for not first lessons' do
        expect(lesson1.previous).to be_nil
        expect(lesson2.previous).to eq lesson1
      end
    end

    describe '#next' do
      it 'should return nil for last lesson and previous lesson for not last lessons' do
        expect(lesson1.next).to eq lesson2
        expect(lesson2.next).to be_nil
      end
    end
  end
end
