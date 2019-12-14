require 'rails_helper'

RSpec.describe CourseAuthorizer do
  let(:user) { insert(:user) }
  let(:course) { insert(:course) }

  describe '#accessable_by?' do
    it 'should be false if user has no user_course' do
      expect(course.accessable_by?(user)).to eq(false)
    end

    it 'should be true if user has user_course' do
      insert(:user_course, user: user, course: course)
      expect(course.accessable_by?(user)).to eq(true)
    end
  end
end
