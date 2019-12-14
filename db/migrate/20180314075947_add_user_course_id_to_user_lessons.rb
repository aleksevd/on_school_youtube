class AddUserCourseIdToUserLessons < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_lessons, :user_course, foreign_key: true
  end
end
