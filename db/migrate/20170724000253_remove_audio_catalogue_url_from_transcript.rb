class RemoveAudioCatalogueUrlFromTranscript < ActiveRecord::Migration[5.2]
  def change
    remove_column :transcripts, :audio_catalogue_url, :string
  end
end
