class AddStopLessonToLesson < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :stop_lesson, :boolean
    add_index :lessons, :stop_lesson, where: "stop_lesson = true"
  end
end
