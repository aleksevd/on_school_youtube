class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :owner_id
      t.string :owner_type
      t.references :user_lesson, foreign_key: true
      t.string :audio
      t.text :text

      t.timestamps
    end

    add_index :answers, [:owner_id, :owner_type]
  end
end
