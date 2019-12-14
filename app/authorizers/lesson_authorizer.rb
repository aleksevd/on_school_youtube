class LessonAuthorizer < ApplicationAuthorizer
  def accessable_by?(user)
    user_lesson = resource.user_lessons.where(user: user).first

    if resource.free?
      user_lesson.present?
    else
      user_lesson&.user_course&.in_open_states?
    end
  end
end