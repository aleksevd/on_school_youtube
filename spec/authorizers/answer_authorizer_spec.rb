require 'rails_helper'

RSpec.describe AnswerAuthorizer do
  let(:user) { insert(:user) }
  let(:lesson) { Lesson.new }
  let(:user_lesson) { UserLesson.new(user: user, lesson: lesson) }

  subject { Answer.new(user_lesson: user_lesson, owner: user) }

  describe '#updatable_by?' do
    it 'should be true if answer has user_lesson belonging to user and user is owner of the answer' do
      expect(subject.updatable_by?(user)).to eq(true)
    end

    context 'when user_lesson does not belong to user' do
      let(:user1) { insert(:user) }

      it 'should be false if user_lesson does not belong to user' do
        expect(subject.updatable_by?(user1)).to eq(false)
      end
    end

    context 'when user is not owner of answer' do
      let(:teacher) { insert(:teacher) }
      subject { Answer.new(user_lesson: user_lesson, owner: teacher) }

      it 'should be false if user_lesson does not belong to user' do
        expect(subject.updatable_by?(user)).to eq(false)
      end
    end
  end
end
