class FixPositionInSections < ActiveRecord::Migration[5.1]
  def change
    remove_column :sections, :position
    add_column :sections, :position, :integer
    add_index :sections, :position
  end
end
