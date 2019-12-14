class AddViewedToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :viewed, :boolean, default: false, null: false
    add_index :answers, :viewed
  end
end
