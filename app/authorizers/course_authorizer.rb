class CourseAuthorizer < ApplicationAuthorizer
  def accessable_by?(user)
    user_course = resource.user_courses.where(user: user).exists?
  end
end