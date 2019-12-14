require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to belong_to(:user_lesson) }
  it { is_expected.to belong_to(:owner) }

  it { is_expected.to validate_presence_of(:user_lesson) }
  it { is_expected.to validate_presence_of(:owner) }

  it { is_expected.to have_many(:answer_images).dependent(:destroy) }

  context 'validation' do
    describe '#content_presence' do
      subject { described_class.new }

      it 'should fail if all content blank' do
        subject.valid?
        expect(subject.errors.full_messages).to include('Ответ не может быть пустым')
      end

      it 'should pass if all content blank but audio has error' do
        subject.errors.add :audio, 'foo'
        subject.valid?
        expect(subject.errors.full_messages).to include('Ответ не может быть пустым')
      end

      context 'when text present' do
        subject { described_class.new(text: 'foo') }

        it 'should pass' do
          subject.valid?
          expect(subject.errors.full_messages).not_to include('Ответ не может быть пустым')
        end
      end

      context 'when audio present' do
        subject { described_class.new }

        it 'should pass' do
          allow(subject).to receive(:audio).and_return('audio')
          subject.valid?
          expect(subject.errors.full_messages).not_to include('Ответ не может быть пустым')
        end
      end

      context 'when images with file are present' do
        subject { described_class.new(answer_images_attributes: [{ file: 'foo' }]) }

        it 'should pass' do
          subject.valid?
          expect(subject.errors.full_messages).not_to include('Ответ не может быть пустым')
        end
      end

      context 'when images are present, but file blank' do
        subject { described_class.new(answer_images_attributes: [{ file: '' }]) }

        it 'should fail' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Ответ не может быть пустым')
        end
      end
    end
  end

  context 'callback' do
    context 'after_create' do
      # describe '#change_user_lesson_state' do
      #   let(:user) { pure(:user) }
      #   let(:user_lesson) { UserLesson.new(user: user) }
      #   subject { described_class.new(user_lesson: user_lesson) }

      #   context 'when user gave answer' do
      #     it 'should touch user_lesson' do
      #       expect(user_lesson).to receive(:touch)
      #       subject.run_callbacks(:save)
      #     end
      #   end
      # end
    end
  end
end
