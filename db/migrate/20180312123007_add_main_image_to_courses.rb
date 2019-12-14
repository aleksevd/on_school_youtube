class AddMainImageToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :main_image, :string
  end
end
