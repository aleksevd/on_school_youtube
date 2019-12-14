class CourseDecorator < ApplicationDecorator
  delegate_all

  def disciplines_names
    disciplines.map(&:name).join(', ')
  end
end
