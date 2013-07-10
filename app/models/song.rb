class Song < ActiveRecord::Base
  attr_accessible :album, :artist, :title, :tracknum, :song

  has_attached_file :song

  validates_attachment_content_type :song , :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
                                     :message => 'file must be of filetype .mp3'
end
