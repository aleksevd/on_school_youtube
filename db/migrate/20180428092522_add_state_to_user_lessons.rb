class AddStateToUserLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :user_lessons, :state, :string
    add_index :user_lessons, :state
  end
end
