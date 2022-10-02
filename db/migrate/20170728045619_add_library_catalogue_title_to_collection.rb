class AddLibraryCatalogueTitleToCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :library_catalogue_title, :string, default: ""
  end
end
