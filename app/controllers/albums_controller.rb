class AlbumsController < ApplicationController
  def index
    @albums = Album.all

    render :index
  end

  def show
    @album = Album.find(params[:id])

    render :show
  end

  def new
    @album = Album.new
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save!
      flash[:notices] = [" Album Created"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = ["Album could not be saved."]
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Bands.all
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      flash[:notices] = ["Album Updated"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = ["Album could not be updated."]
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])

    @album.destroy!

    redirect_to albums_url
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :album_kind)
  end

end
