class BandsController < ApplicationController
  before_action :ensure_admin!, only: [:create, :update, :destroy]



  def index
    @bands = Band.all

    render :index
  end

  def show
    @band = Band.find(params[:id])
    @albums = @band.albums
    @tracks = @band.tracks
    render :show
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:notices] = [" Band Created"]
      redirect_to band_url(@band)
    else
      flash.now[:errors] = ["Band could not be saved."]
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(band_params)
      flash[:notices] = ["Band Updated"]
      redirect_to band_url(@band)
    else
      flash.now[:errors] = ["Band could not be updated."]
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])

    @band.destroy!

    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end


end
