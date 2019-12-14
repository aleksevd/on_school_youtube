class AddSectionToLessons < ActiveRecord::Migration[5.1]
  def change
    add_reference :lessons, :section, foreign_key: true
  end
end
