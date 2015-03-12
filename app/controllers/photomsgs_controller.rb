class PhotomsgsController < ApplicationController
respond_to :html, :json
def new
  @photomsg = Photomsg.new
  respond_with(@photomsg)
end

def create
  @photomsg = Photomsg.new(photo_params)
 
  respond_to do |format|
      if @photomsg.save
        format.json { render json: @photomsg, status: :created }
        format.xml { render xml: @photomsg, status: :created }
      else
        format.json { render json: @photomsg.errors, status: :unprocessable_entity }
        format.xml { render xml: @photomsg.errors, status: :unprocessable_entity }
      end
    end
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
private
  def photo_params
    params.require(:photomsg).permit(:title, :physician, :patient)
  end

end
