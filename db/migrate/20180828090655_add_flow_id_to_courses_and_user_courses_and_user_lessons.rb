class AddFlowIdToCoursesAndUserCoursesAndUserLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :user_courses, :flow_id, :integer

    add_index :user_courses, :flow_id
  end
end
