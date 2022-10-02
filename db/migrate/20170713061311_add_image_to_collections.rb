class AddImageToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :image, :string, default: nil
  end
end
