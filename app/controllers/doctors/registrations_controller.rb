class Doctors::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_hospitaladmin!

  respond_to :html
  # GET /resource/sign_up
   def new
    @doctor = Doctor.new
    super
   end

  # POST /resource
   def create
    @doctor = Doctor.new(doctor_params)
    
    @doctor.hospitaladmin_id = current_hospitaladmin.id
    if @doctor.errors.blank?
       @doctor.save
    UserNotifier.send_doctor_email(@doctor).deliver   
    redirect_to new_doctor_registration_path
    else
      redirect_to new_doctor_registration_path
    end
   end

  # GET /resource/edit
   def edit
     super
   end

  # PUT /resource
   def update
     super
   end

  # DELETE /resource
   def destroy
     super
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    def doctor_params
      params.require(:doctor).permit(:name, :email, :emp_id, :password, :password_confirmation)
    end

end
