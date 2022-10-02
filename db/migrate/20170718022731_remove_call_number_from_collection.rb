class RemoveCallNumberFromCollection < ActiveRecord::Migration[5.2]
  def change
    remove_column :collections, :call_number, :string
  end
end
