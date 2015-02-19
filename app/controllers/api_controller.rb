class ApiController < ApplicationController
  respond_to :json
  def patients
    @physician = params[:physician]
    @patients = Patient.where(:discharge_status => 0, :physician => @physician)
    if @patients.empty?
      patients = ActiveSupport::HashWithIndifferentAccess.new
      patients[:success] = 0
      patients[:msg] = 'no data available'
      patients[:data] = ''
     respond_with(patients)
    else
      patients = ActiveSupport::HashWithIndifferentAccess.new
      patients[:success] = 1
      patients[:msg] = 'succesfully get data'
      patients[:data] = @patients 
     respond_with(patients)
    end 
  end
    def disease
      @hospitaladmin_id = params[:hospitaladmin_id]
      @disease = Diseasecode.where(:hospitaladmin_id => @hospitaladmin_id)
      if @disease.empty?
        disease = ActiveSupport::HashWithIndifferentAccess.new
        disease[:success] = 0
        disease[:msg] = 'no data available'
        disease[:data] = ''
        respond_with(disease)
      else
        disease = ActiveSupport::HashWithIndifferentAccess.new
        disease[:success] = 1
        disease[:msg] = 'succesfully get data'
        disease[:data] = @disease 
      respond_with(disease)
    end 
  end
  def addpatient
  	  @patient = Patient.create(params[:id])
      if params[:first_name].empty?
         addpatient = ActiveSupport::HashWithIndifferentAccess.new
        addpatient[:success] = 0
        addpatient[:msg] = 'empty first name'
        addpatient[:data] = ''
        respond_with(addpatient) 
      elsif  params[:last_name].empty?
         addpatient = ActiveSupport::HashWithIndifferentAccess.new
        addpatient[:success] = 0
        addpatient[:msg] = 'empty last name'
        addpatient[:data] = ''
        respond_with(addpatient)
      elsif  params[:hospitaladmin_id].empty?
         addpatient = ActiveSupport::HashWithIndifferentAccess.new
        addpatient[:success] = 0
        addpatient[:msg] = 'empty hospitaladmin id'
        addpatient[:data] = ''
        respond_with(addpatient)
        elsif  params[:physician].empty?
         addpatient = ActiveSupport::HashWithIndifferentAccess.new
        addpatient[:success] = 0
        addpatient[:msg] = 'empty physician'
        addpatient[:data] = ''
        respond_with(addpatient)        
      else
  	  @patient.first_name = params[:first_name]
      @patient.last_name = params[:last_name]
      @patient.email = params[:email]
  	  @patient.hospitaladmin_id = params[:hospitaladmin_id]
  	  @patient.gender = params[:gender]
      @patient.date_of_birth = params[:date_of_birth]
      @patient.mi = params[:mi]
  	  @patient.contact_no = params[:contact_no]
  	  @patient.physician = params[:physician]
  	  @patient.discharge_status = 0
    if @patient.save
        addpatient = ActiveSupport::HashWithIndifferentAccess.new
        addpatient[:success] = 1
        addpatient[:msg] = 'succesfully save data'
        addpatient[:data] = @patient
        respond_with(addpatient)
    else
        addpatient = ActiveSupport::HashWithIndifferentAccess.new
        addpatient[:success] = 0
        addpatient[:msg] = 'no data save'
        addpatient[:data] = ''
        respond_with(addpatient)
    end 
    end   
  end  
   def destroy
    @patient = Patient.where(:id => params[:id])
      if @patient.blank?
        destroy = ActiveSupport::HashWithIndifferentAccess.new
        destroy[:success] = 0
        destroy[:msg] = 'no data available'
        destroy[:data] = ''
        respond_with(destroy)
      else
        @patient1 = Patient.find(params[:id])
          if @patient1.destroy
            destroy = ActiveSupport::HashWithIndifferentAccess.new
            destroy[:success] = 1
            destroy[:msg] = 'succesfully delete data'
            destroy[:data] = ''
            respond_with(destroy)
          else
            #format.json { render json: @patient1.errors, status: :unprocessable_entity }
            destroy = ActiveSupport::HashWithIndifferentAccess.new
            destroy[:success] = 0
            destroy[:msg] = 'no data available'
            destroy[:data] = ''
            respond_with(destroy)
          end
      end
   end
  def singlepatient
    @patient = Patient.where(:id => params[:id])
    if @patient.empty?
      singlepatient = ActiveSupport::HashWithIndifferentAccess.new
      singlepatient[:success] = 0
      singlepatient[:msg] = 'no data available'
      singlepatient[:data] = ''
     respond_with(singlepatient)
    else
      singlepatient = ActiveSupport::HashWithIndifferentAccess.new
      singlepatient[:success] = 1
      singlepatient[:msg] = 'succesfully get data'
      singlepatient[:data] = @patient
     respond_with(singlepatient)
    end 
  end
  def login
    @email = params[:email]
    @pass = params[:pass]
    @doctor = Doctor.find_by_email(@email)
    if @doctor.nil?
      doctor = ActiveSupport::HashWithIndifferentAccess.new
      doctor[:success] = 0
      doctor[:msg] = 'user not available'
      doctor[:data] = ''
     respond_with(doctor)
    else
      if(@doctor.valid_password?(@pass))
        doctor = ActiveSupport::HashWithIndifferentAccess.new
        doctor[:success] = 1
        doctor[:msg] = 'succesfully get data'
        doctor[:data] = @doctor
        respond_with(doctor)
      else
        doctor = ActiveSupport::HashWithIndifferentAccess.new
        doctor[:success] = 0
        doctor[:msg] = 'wrong password'
        doctor[:data] = ''
        respond_with(doctor)
      end  
    end
  end

  def discharge
    @discharge_patient = Patient.where(:id => params[:id])
    @discharged = Patient.where(:id => params[:id], :discharge_status => 1)
    if @discharge_patient.empty?
      discharge = ActiveSupport::HashWithIndifferentAccess.new
      discharge[:success] = 0
      discharge[:msg] = 'no data available'
      discharge[:data] = ''
     respond_with(discharge)
    elsif !@discharged.empty?
         @update = Patient.update(params[:id], discharge_status: 1)
         addpatient = ActiveSupport::HashWithIndifferentAccess.new
         addpatient[:success] = 0
         addpatient[:msg] = 'patient already discharge'
         addpatient[:data] = ''
         respond_with(addpatient)
    else @update = Patient.update(params[:id], discharge_status: 1)
         addpatient = ActiveSupport::HashWithIndifferentAccess.new
         addpatient[:success] = 1
         addpatient[:msg] = 'succesfully discharge patient'
         addpatient[:data] = ''
         respond_with(addpatient)     
   
    end  
  end  
  def diseasecode
      @hospitaladmin_id = params[:hospitaladmin_id]
        @disease = Diseasecode.where(:hospitaladmin_id => @hospitaladmin_id)
      if @disease.empty?
        disease = ActiveSupport::HashWithIndifferentAccess.new
        disease[:success] = 0
        disease[:msg] = 'no data available'
        disease[:data] = ''
        respond_with(disease)
      else
        disease = ActiveSupport::HashWithIndifferentAccess.new
        disease[:success] = 1
        disease[:msg] = 'succesfully get data'
        disease[:data] = @disease 
      respond_with(disease)
    end 
  end  
      def patient_params
      params.require(:patient).permit(:d_id, :first_name, :last_name, :email, :hospitaladmin_id, :mi, :contact_no, :physician)
    end
end
