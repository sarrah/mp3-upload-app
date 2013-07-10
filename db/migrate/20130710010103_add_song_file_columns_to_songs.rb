class AddSongFileColumnsToSongs < ActiveRecord::Migration
  def change
    add_attachment :songs, :song
  end
end
