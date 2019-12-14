class AddMainImageToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :main_image, :string
  end
end
