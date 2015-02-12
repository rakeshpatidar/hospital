class ApiController < ApplicationController
  respond_to :json
  def patient
    @d_id = params[:d_id]
    @patients = Patient.where(:discharge_status => 0, :physician => @d_id)
    if @patients.empty?
     respond_with('Not available')
    else
     respond_with(@patients)
    end 
  end
    def disease
   @diseasecode = Diseasecode.all
     respond_with(@diseasecode)
  end
  def addpatient
  	  @patient = Patient.create(params[:id])
  	  @patient.first_name = params[:first_name]
      @patient.last_name = params[:last_name]
      @patient.email = params[:email]
  	  @patient.hospitaladmin_id = params[:hospitaladmin_id]
  	  @patient.mi = params[:mi]
  	  @patient.contact_no = params[:contact_no]
  	  @patient.physician = params[:physician]
  	  @patient.discharge_status = 0
  flash[:notice] = 'Patient was successfully created.' if @patient.save
  respond_with(@patient)
  end

   def destroy
    @patient = Patient.where(:id => params[:id])
      if @patient.blank?
        respond_to do |format|  ## Add this
          format.json { render :json => ('Not available')}
        end 
      else
    respond_to do |format|
      @patient1 = Patient.find(params[:id])
      if @patient1.destroy
        format.json { render :json => ('success') }
      else
        format.json { render json: @patient1.errors, status: :unprocessable_entity }
      end
     end 
    end
  end
  def singlepatient
    @patient = Patient.where(:id => params[:id])
    if @patient.empty?
     respond_with('Not available')
    else
     respond_with(@patient)
    end 
  end
      def patient_params
      params.require(:patient).permit(:d_id, :first_name, :last_name, :email, :hospitaladmin_id, :mi, :contact_no, :physician)
    end
end
