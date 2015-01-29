class Doctors::SessionsController < Devise::SessionsController
respond_to :html, :json
def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_to do |format|  
      format.html { respond_with resource, :location => after_sign_in_path_for(resource) }  
      format.json {  
         return render :json => {  :success => true, 
          
         } 
      }  
    end
  end
  def destroy  
    super  
  end  
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
