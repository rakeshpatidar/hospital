class ApiController < ApplicationController
  respond_to :json
  def patient
   @patients = Patient.where(:discharge_status => 0)
     respond_with(@patients)
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

      def patient_params
      params.require(:patient).permit(:first_name, :last_name, :email, :hospitaladmin_id, :mi, :contact_no, :physician)
    end
end
