class AddCallNumberToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :call_number, :string, null: false, default: ""
  end
end
