class PhotosController < ApplicationController 
  
  def index
    @photos = Photo.all
  end

  def new
  end

  # /photos/:id/edit 
  def edit
    @id = params[:id]
  end

  def update
    photo = Photo.find( params[:id] )
    photo.title = params[:photo][:title]
    photo.image_url = params[:photo][:image_url]

    photo.save
  end

  def show 
    @photo = Photo.find(params[:id])
  end 

  def create
    photo = Photo.new
    photo.title = params[:photo][:title]
    photo.image_url = params[:photo][:image_url]
    photo.save

    redirect_to "/photos/#{photo_id}"
    # también podemos pasar directamente el obj "photo" 
  end

  #DELETE /photos/:id
  def destroy
    photo = Photo.find(params[:id])
    photo.destroy

    redirect_to '/photos'
  end

end