require 'rails_helper'

RSpec.describe LessonAuthorizer do
  let(:user) { insert(:user) }

  describe '#accessable_by?' do
    context 'when lesson is free' do
      let(:lesson) { insert(:lesson, free: true) }

      it 'should be false if user has no user_lesson' do
        expect(lesson.accessable_by?(user)).to eq(false)
      end

      it 'should be true if user has user_lesson' do
        insert(:user_lesson, user: user, lesson: lesson)
        expect(lesson.accessable_by?(user)).to eq(true)
      end
    end

    context 'when lesson is not free' do
      let(:lesson) { insert(:lesson) }

      it 'should be false if user has no user_lesson' do
        expect(lesson.accessable_by?(user)).to be_falsey
      end

      context 'when user_course is not in open state' do
        let(:user_course) { insert(:user_course) }

        it 'should be false if user has user_lesson but course is not opened' do
          insert(:user_lesson, user: user, lesson: lesson, user_course: user_course)
          expect(lesson.accessable_by?(user)).to eq(false)
        end
      end

      context 'when user_course is in open state' do
        let(:user_course) { insert(:user_course, state: :active) }

        it 'should be false if user has user_lesson but course is not opened' do
          insert(:user_lesson, user: user, lesson: lesson, user_course: user_course)
          expect(lesson.accessable_by?(user)).to eq(true)
        end
      end
    end
  end
end
