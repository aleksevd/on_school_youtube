class AddUniqIndexesToUserCoursesAndUserLessons < ActiveRecord::Migration[5.1]
  def change
    add_index :user_courses, [:course_id, :user_id], unique: true
    add_index :user_lessons, [:lesson_id, :user_id], unique: true
  end
end
