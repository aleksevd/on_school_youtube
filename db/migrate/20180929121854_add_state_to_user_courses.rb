class AddStateToUserCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :user_courses, :state, :string
    add_index :user_courses, :state
  end
end
