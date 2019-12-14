class AddIndexOnStateInFlows < ActiveRecord::Migration[5.1]
  def change
    add_index :flows, :state
  end
end
