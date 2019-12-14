class FlowAuthorizer < ApplicationAuthorizer
  def accessable_by?(user)
    resource.user_courses.where(user: user).exists?
  end
end