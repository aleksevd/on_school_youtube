class AnswerAuthorizer < ApplicationAuthorizer
  def updatable_by?(user)
    resource.user_lesson.user_id == user.id && resource.owner == user
  end
end