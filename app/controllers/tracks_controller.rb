class TracksController < ApplicationController

  def index
    @tracks = Track.all

    render :index
  end

  def show

    @track = Track.find(params[:id])
    @notes = @track.notes
    render :show
  end

  def new
    @track = Track.new
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save!
      flash[:notices] = [" Track Created"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = ["Track could not be saved."]
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Albums.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      flash[:notices] = [" Track Updated"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = ["Track could not be updated."]
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])

    @track.destroy!

    redirect_to tracks_url
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :track_kind, :lyrics)
  end

end
