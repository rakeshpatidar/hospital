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
  	  @patient.name = params[:name]
  	  @patient.hospitaladmin_id = params[:hospitaladmin_id]
  	  @patient.gender = params[:gender]
  	  @patient.date_of_birth = params[:date_of_birth]
  	  @patient.contact_no = params[:contact_no]
  	  @patient.billing_id = params[:billing_id]
  	  @patient.physician = params[:physician]
  	  @patient.discharge_status = 0
  flash[:notice] = 'Patient was successfully created.' if @patient.save
  respond_with(@patient)
  end

      def patient_params
      params.require(:patient).permit(:name, :hospitaladmin_id, :gender, :date_of_birth, :contact_no, :billing_id, :physician)
    end
end
