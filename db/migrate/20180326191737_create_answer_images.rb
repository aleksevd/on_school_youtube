class CreateAnswerImages < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_images do |t|
      t.references :answer, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
