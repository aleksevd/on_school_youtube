class DisciplineCourse < ApplicationRecord
  belongs_to :discipline
  belongs_to :course
end
