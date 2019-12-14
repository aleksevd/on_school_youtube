require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { insert(:user) }
  let(:course) { insert(:course) }
  let(:flow) { insert(:flow, course: course) }

  it { is_expected.to have_many(:user_courses).dependent(:destroy) }
  it { is_expected.to have_many(:courses).through(:user_courses) }
  it { is_expected.to have_many(:user_lessons).dependent(:destroy) }
  it { is_expected.to have_many(:lessons).through(:user_lessons) }
  it { is_expected.to have_many(:answers).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  describe '#add_course' do
    it 'should add user_course' do
      expect{ user.add_course(flow) }.to change{ user.user_courses.count }.from(0).to(1)

      expect(user.user_courses.first.course_id).to eq course.id
    end

    it 'should not add same user_course' do
      insert(:user_course, user: user, course: course, flow: flow)

      expect{ user.add_course(flow) }.not_to change{ user.user_courses.count }
    end
  end

  describe '#add_lesson' do
    let(:course) { insert(:course) }
    let(:lesson) { insert(:lesson, course: course) }
    let!(:user_course) { insert(:user_course, user: user, course: course) }

    it 'should add user_lesson with user_course' do
      expect{ user.add_lesson(lesson, user_course) }.to change{ user.user_lessons.count }.from(0).to(1)

      expect(user.user_lessons.first).to have_attributes lesson_id: lesson.id,
                                                         user_course_id: user_course.id
    end

    it 'should not add same user_lesson' do
      insert(:user_lesson, user: user, lesson: lesson, user_course: user_course)

      expect{ user.add_lesson(lesson, user_course) }.not_to change{ user.user_courses.count }
    end
  end

  describe '#add_lessons' do
    let(:course) { insert(:course) }
    let(:lesson1) { insert(:lesson, course: course) }
    let(:lesson2) { insert(:lesson, course: course) }
    let!(:user_course) { insert(:user_course, user: user, course: course) }

    it 'should add user_lesson for all_lessons' do
      expect{ user.add_lessons([lesson1, lesson2], user_course) }.to change{ user.user_lessons.count }.from(0).to(2)
    end
  end
end
