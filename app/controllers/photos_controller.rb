class PhotosController < ApplicationController 
  # los controllers por convención se designan en plural y para asociar una ruta a un controller, se puede usar resources :photos (plural)

  before_action :set_photo, only: [:how, :update, :destroy]
  
  def index
    @photos = Photo.all

    flash[:alert] = "Algo salió mal"
  end

  def show 
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @photo }
      #por defecto usa html, sino intenta json
      #si solo queremos responder de forma exitosa, head solo responde encabezado.
    end 
  end

  def new
    session[:intentos] = session[:intentos] ? session[:intentos] + 1 : 1
    #si queremos cambiar la vista a la que va, podemos redirigirlo, también se puede utilizar en formato json
    # render 'new_view'
    # render json: @photo #retorna un json
  end

  # /photos/:id/edit 
  def edit
    @id = params[:id]
  end

  def update
    @photo.update(photo_params)
    redirect_to @photo
  end

  def create
    @photo = Photo.new(photo_params)
    
    respond_to do |format| 
      if @photo.save
        format.html { redirect_to @photo, notice: "Todo salió bien" }
        format.json { render json: @photo, status: :created }
      else
        format.html { redirect_to photos_path, notice: 'Algo falló' }
      end
    end
  end

    #por defecto usa html, sino intenta json
    # redirect_to "/photos/#{photo_id}"
    # también podemos pasar directamente el obj "photo"

  #DELETE /photos/:id
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html {redirect_to photos_path }
      format.json {head :no_content}
    end
  end

  private

  def set_photo
      @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :image_url, :todo_id, tag_ids: [])
    # los pararms con arreglos tienen que ir al final siempre, no puede haber otra opción después.
  end

end