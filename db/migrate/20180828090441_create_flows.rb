class CreateFlows < ActiveRecord::Migration[5.1]
  def change
    create_table :flows do |t|
      t.references :course, foreign_key: true
      t.string :state
      t.datetime :starts_at
      t.datetime :checks_finish_at
      t.datetime :finishes_at
      t.integer :price

      t.timestamps
    end
  end
end
