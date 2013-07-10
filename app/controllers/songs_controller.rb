require "mp3info"

class SongsController < ApplicationController

  def index
    @qstr_title = params[:qstr_title]
    @qstr_artist = params[:qstr_artist]
    @qstr_album = params[:qstr_album]
    
    @res = Song.where("title like ? AND artist like ? AND album like ?", "%#{@qstr_title}%", "%#{@qstr_artist}%", "%#{@qstr_album}%")

    if !@qstr_title.blank? || !@qstr_artist.blank? || !@qstr_album.blank?
      @songs = @res
      @from_search = true
    else
      @songs = Song.all
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.create(params[:song])
    if @song.song.exists?
      @song_file = Mp3Info.open(@song.song.path)
      @song.title = @song_file.tag.title
      @song.artist = @song_file.tag.artist
      @song.album = @song_file.tag.album
      @song.tracknum = @song_file.tag.tracknum
      Rails.logger.info "==================  #{@song}  ====================="
      Rails.logger.info "==================  #{@song.title} // #{@song.artist} // #{@song.album} // #{@song.tracknum}  ====================="
    else
      @error = true
    end
    if @song.save && !@error
      flash[:notice] = "Song succesfully added!"
      redirect_to songs_path
    else
      flash[:notice] = "Cannot save file. Only MP3 files are allowed."
      redirect_to songs_path
    end
  end

  def search
    @qstr_title = params[:qstr_title]
    @qstr_artist = params[:qstr_artist]
    @qstr_album = params[:qstr_album]
    @res = Song.where("title like ? AND artist like ? AND album like ?", "%#{@qstr_title}%", "%#{@qstr_artist}%", "%#{@qstr_album}%")
  end

end
