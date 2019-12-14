class SectionDecorator < ApplicationDecorator
  delegate_all

  def collapse_id
    "section-#{section.position}"
  end

  def active_for(lesson)
    id == lesson.section_id
  end
end
