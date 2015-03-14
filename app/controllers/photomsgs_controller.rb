class PhotomsgsController < ApplicationController
respond_to :html, :json
def new
  @photomsg = Photomsg.new
  respond_with(@photomsg)
end

def create
@photomsgs = Photomsg.all
respond_with(@photomsgs)
end 
 
def index
  @photomsgs = Photomsg.all
  respond_with(@photomsgs)
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

  def photo_params
    params.require(:photomsg).permit(:title, :physician, :patient)
  end

end
