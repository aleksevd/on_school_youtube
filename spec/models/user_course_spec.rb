require 'rails_helper'

RSpec.describe UserCourse, type: :model do
  let(:user) { insert(:user) }
  let(:course) { insert(:course) }
  let(:flow) { insert(:flow, course: course, state: :active) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:course) }
  it { is_expected.to belong_to(:flow) }
  it { is_expected.to have_many(:user_lessons) }

  it { is_expected.to validate_presence_of(:course) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:flow) }

  context 'when uniqueness validation' do
    let!(:user_course) { insert(:user_course, user: user, course: course) }
    let!(:new_user_course) { described_class.new(user: user, course: course) }

    it 'should not let create same user_course' do
      expect(new_user_course).not_to be_valid

      expect(new_user_course.errors.full_messages).to include 'Course уже существует'
    end
  end

  context 'callback' do
    context 'after_create' do
      describe '#add_free_lessons' do
        let!(:lesson1) { insert(:lesson, course: course, position: 1, free: true) }
        let!(:lesson2) { insert(:lesson, course: course, position: 2) }

        subject { described_class.create!(user: user, course: course, flow: flow )}

        it 'should create user_lessons for all free lessons' do
          expect{ subject }.to change{ UserLesson.count }.from(0).to(1)

          expect(user.user_lessons.pluck(:lesson_id)).to eq([lesson1.id])
          expect(subject.user_lessons.pluck(:lesson_id)).to eq([lesson1.id])
        end
      end
    end
  end

  describe 'state_machine' do
    context 'event' do
      describe '#activate' do
        let(:user_course) { described_class.create!(user: user, course: course, flow: flow, paid: paid) }

        before do
          user_course.activate
        end

        context 'when user_course is paid and flow is activated' do
          let(:paid) { true }

          it 'should transit to active state' do
            user_course.activate

            expect(user_course).to be_active
          end
        end

        context 'when user_course is not paid and flow is activated' do
          let(:paid) { false }

          it 'should not transit to active state' do
            user_course.activate

            expect(user_course).to be_inactive
          end
        end

        context 'when user_course is paid and flow is not activated' do
          let(:paid) { true }
          let(:flow) { insert(:flow, course: course) }

          it 'should not transit to active state' do
            user_course.activate

            expect(user_course).to be_inactive
          end
        end
      end
    end

    context 'callback' do
      context 'after_transition' do
        describe 'add_first_lessons_batch_to_users' do
          let(:user_course) { described_class.create!(user: user, course: course, flow: flow, paid: true) }
          subject { user_course.activate }

          context 'without stop_lessons' do
            let!(:lesson1) { insert(:lesson, course: course, position: 1) }
            let!(:lesson2) { insert(:lesson, course: course, position: 2) }

            it 'should create user_lessons for all lessons if no stop lesson' do
              expect{ subject }.to change{ UserLesson.count }.from(0).to(2)

              expect(user.user_lessons.pluck(:lesson_id).sort).to eq([lesson1.id, lesson2.id].sort)
              expect(user_course.user_lessons.pluck(:lesson_id).sort).to eq([lesson1.id, lesson2.id].sort)
            end
          end

          context 'with stop_lesson' do
            let!(:lesson1) { insert(:lesson, course: course, position: 1) }
            let!(:lesson2) { insert(:lesson, course: course, position: 2, stop_lesson: true) }
            let!(:lesson3) { insert(:lesson, course: course, position: 3) }

            it 'should create user_lessons for first batch before stop lesson' do
              expect{ subject }.to change{ UserLesson.count }.from(0).to(2)

              expect(user.user_lessons.pluck(:lesson_id).sort).to eq([lesson1.id, lesson2.id].sort)
              expect(user_course.user_lessons.pluck(:lesson_id).sort).to eq([lesson1.id, lesson2.id].sort)
            end
          end
        end
      end
    end
  end
end
