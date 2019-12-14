class AddFreeToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :free, :boolean, default: false, null: false
    add_index :lessons, :free, where: "free = true"
  end
end
