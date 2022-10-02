class AddPublishedToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column(:collections, :published_at, :datetime, default: nil)
  end
end
