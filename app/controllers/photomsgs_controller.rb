class PhotomsgsController < ApplicationController
respond_to :html, :json
def new
  @photomsg = Photomsg.new
  respond_with(@photomsg)
end

def create
  @photomsg = Photomsg.new(photo_params)
  @photomsg.patient_id = params[:id]   #set patient id
  if @photomsg.save
    respond_to do |format|
      format.html { redirect_to(@photomsg, :notice => 'photomsg was successfully created.') }
      msg = { :success => 1, :msg => "data save Success!", :data => "" }
      format.json  { render :json => msg }
    end
  else
    respond_to do |format|
      format.html { redirect_to(@photomsg, :notice => 'photomsg was fail to created.') }
      msg = { :success => 0, :msg => "data not save", :data => "" }
      format.json  { render :json => msg }
      
    end
end
end 
 
def index
  @photomsgs = Photomsg.all
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
    params.permit(:image, :physician)
  end

end
