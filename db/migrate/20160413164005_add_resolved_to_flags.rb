class AddResolvedToFlags < ActiveRecord::Migration[5.2]
  def change
    add_column :flags, :is_resolved, :integer, :null => false, :default => 0
  end
end
