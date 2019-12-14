class CreateDisciplineCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :discipline_courses do |t|
      t.references :discipline, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
