class AddHomeworkToLesson < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :homework, :text
  end
end
