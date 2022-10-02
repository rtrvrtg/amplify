class AddCanDownloadToTranscripts < ActiveRecord::Migration[5.2]
  def change
    add_column :transcripts, :can_download, :integer, :null => false, :default => 1
  end
end
