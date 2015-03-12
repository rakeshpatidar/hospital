class PhotomsgsController < ApplicationController
respond_to :html, :json
def new
  @photomsg = Photomsg.new
  respond_with(@photomsg)
end

def create
    @Photomsg = Photomsg.new(params[:photomsg])
    respond_to do |format|
      if @Photomsg.save
        format.json { render json: @Photomsg, status: :created }
        format.xml { render xml: @Photomsg, status: :created }
      else
        format.json { render json: @Photomsg.errors, status: :unprocessable_entity }
        format.xml { render xml: @Photomsg.errors, status: :unprocessable_entity }
      end
    end
  end

def create
  @photomsg = Photomsg.new(photo_params)
 
  if @photomsg.save
    respond_to do |format|
      format.html { redirect_to(@photomsg, :notice => 'photomsg was successfully created.') }
      format.json { render :json => @photomsg, :status => 1, :data => ''} 
    end
  else
    respond_to do |format|
      format.html { redirect_to(@photomsg, :notice => 'photomsg was fail to created.') }
      format.json { render :json => @photomsg.errors, :status => :unprocessable_entity} 
      
    end
end
end 
 
def index
  @photomsgs = Photomsg.all
  respond_to do |format|
      format.json { render json: @photomsgs }
      format.xml { render xml: @photomsgs }
    end
end

def edit
  
end

def update
  
end 
 
def destroy
 
end
def show
  @photomsg = Photomsg.find(params[:id])
end 
private
  def photo_params
    params.require(:photomsg).permit(:title, :image, :physician, :patient)
  end

end
