class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
