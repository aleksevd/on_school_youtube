class AddWithoutHomeworkToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :without_homework, :boolean
  end
end
