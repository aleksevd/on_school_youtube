class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.text :description

      t.timestamps
    end
  end
end
