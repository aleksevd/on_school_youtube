class AddPayedToUserCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :user_courses, :paid, :boolean, default: false, null: false
  end
end
