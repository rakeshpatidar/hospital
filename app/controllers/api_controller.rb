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
  def dischargepatients
    @physician = params[:physician]
    @patients = Patient.where(:discharge_status => 1, :physician => @physician)
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
        @patientdisease = Patientdisease.find_by patient_id: params[:id] #get asigned code
        @patientmsg = Patientmsg.find_by patient_id: params[:id]  # Get patient Message from patient id
        if(params[:msg_delete] == '1')  # delete the message of patient if request is 1
          @patientmsg.destroy
        else                            # entry go on archive if request is 0
          @archivelist = Archivemsg.create()
          @archivelist.patient = params[:id]
          @archivelist.physician = @patientmsg.physician
          @archivelist.text_msg = @patientmsg.text_msg
          @patientname = Patient.find_by id: params[:id]   #find patient name
          @archivelist.patient_name = @patientname.first_name
          @doctorname = Doctor.find_by id: @patientmsg.physician  #find doctor name
          @archivelist.physician_name = @doctorname.name
          @archivelist.save
          @patientmsg.destroy       #delete the asigned message
          @patientdisease.destroy   #delete the asigned code
        end   
          @patient1 = Patient.find_by id: params[:id] 
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

  def patientdisease
    if params[:id].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty patient id'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)
    elsif params[:code].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty code data'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)
    elsif params[:disease].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty disease'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)    
    else    
        @patient = Patient.where(:id => params[:id])
        @code = params[:code]
        @disease = params[:disease]
        @Patientdisease = Patientdisease.where(:patient_id => params[:id])
        if @Patientdisease.empty?
          @patientdisease = @patient.patientdiseases.create()
          @patientdisease.code = @code
          @patientdisease.disease = @disease

             if @patientdisease.save
                 patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
                 patientdiseasecode[:success] = 1
                 patientdiseasecode[:msg] = 'succesfully save data'
                 patientdiseasecode[:data] = @patientdisease
                 respond_with(patientdiseasecode)
                else
                 patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
                 patientdiseasecode[:success] = 0
                 patientdiseasecode[:msg] = 'no data save'
                 patientdiseasecode[:data] = ''
                 respond_with(patientdiseasecode)
             end
        else
           patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
           patientdiseasecode[:success] = 0
           patientdiseasecode[:msg] = 'already save data'
           patientdiseasecode[:data] = ''
           respond_with(patientdiseasecode) 
        end
      end      
  end 
  def patientmsg  #old text message add api
    if params[:id].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty patient id'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)
    elsif params[:physician].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty physician data'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)
    elsif params[:text_msg].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty message data'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)
    elsif
        @patient = Patient.where(:id => params[:id])
        @text_msg = params[:text_msg]
          if @patient.empty?
            patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
            patientdiseasecode[:success] = 0
            patientdiseasecode[:msg] = 'patient not available'
            patientdiseasecode[:data] = ''
            respond_with(patientdiseasecode)
          else
          
            @patientmsg1 = Patientmsg.new()
            @patientmsg1.patient_id = params[:id]
            @patientmsg1.physician = params[:physician]
            @patientmsg1.text_msg = @text_msg
            if @patientmsg1.save
               patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
               patientdiseasecode[:success] = 1
               patientdiseasecode[:msg] = 'message save succesfully'
               patientdiseasecode[:data] = @patientmsg1
               respond_with(patientdiseasecode)
            else
               patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
               patientdiseasecode[:success] = 0
               patientdiseasecode[:msg] = 'message not save'
               patientdiseasecode[:data] = ''
               respond_with(patientdiseasecode)
            end 
            
          end  
    end  
  end
def addpatientmsg      #new text message add api
    if params[:id].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty patient id'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)
    elsif params[:physician].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty physician data'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)
    elsif params[:text_msg].empty?
        patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
        patientdiseasecode[:success] = 0
        patientdiseasecode[:msg] = 'empty message data'
        patientdiseasecode[:data] = ''
        respond_with(patientdiseasecode)
    elsif
        @patient = Patient.where(:id => params[:id])
        @text_msg = params[:text_msg]
          if @patient.empty?
            patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
            patientdiseasecode[:success] = 0
            patientdiseasecode[:msg] = 'patient not available'
            patientdiseasecode[:data] = ''
            respond_with(patientdiseasecode)
          else
          
            @patientmsg1 = Patientmsg.new()
            @patientmsg1.patient_id = params[:id]
            @patientmsg1.physician = params[:physician]
            @patientmsg1.text_msg = @text_msg
            if @patientmsg1.save
               patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
               patientdiseasecode[:success] = 1
               patientdiseasecode[:msg] = 'message save succesfully'
               patientdiseasecode[:data] = @patientmsg1
               respond_with(patientdiseasecode)
            else
               patientdiseasecode = ActiveSupport::HashWithIndifferentAccess.new
               patientdiseasecode[:success] = 0
               patientdiseasecode[:msg] = 'message not save'
               patientdiseasecode[:data] = ''
               respond_with(patientdiseasecode)
            end 
            
          end  
    end  
  end
  def patientmsglist
      @patientmsglist = Patientmsg.where(:patient_id => params[:id])  #id of the patientid id
      if @patientmsglist.empty?
        patientmsglist = ActiveSupport::HashWithIndifferentAccess.new
        patientmsglist[:success] = 0
        patientmsglist[:msg] = 'data not available'
        patientmsglist[:data] = ''
        respond_with(patientmsglist)     
      else
        patientmsglist = ActiveSupport::HashWithIndifferentAccess.new
        patientmsglist[:success] = 1
        patientmsglist[:msg] = 'Succesfully get data'
        patientmsglist[:data] = @patientmsglist
        respond_with(patientmsglist)    
      end 
  end
  def patientmsgedit
    @patientmsgedit = Patientmsg.where(:text_msg_id => params[:text_msg_id])  #id of the pataintmsg id
    if @patientmsgedit.empty?
        patientmsgedit = ActiveSupport::HashWithIndifferentAccess.new
        patientmsgedit[:success] = 0
        patientmsgedit[:msg] = 'data not available'
        patientmsgedit[:data] = ''
        respond_with(patientmsgedit)     
    else
      Patientmsg.where(:text_msg_id => params[:text_msg_id]).update_all('text_msg' => params[:text_msg])
      @patientmsgedit = Patientmsg.where(:text_msg_id => params[:text_msg_id])  #id of the pataintmsg id
      patientmsgedit = ActiveSupport::HashWithIndifferentAccess.new
      patientmsgedit[:success] = 1
      patientmsgedit[:msg] = 'data updated'
      patientmsgedit[:data] = ''
      respond_with(patientmsgedit)   
    end  

  end
  def archivemsg
     @listarchive = Archivemsg.where(:physician => params[:physician])
     if @listarchive.empty?
        archivelist = ActiveSupport::HashWithIndifferentAccess.new
        archivelist[:success] = 0
        archivelist[:msg] = 'data not available'
        archivelist[:data] = ''
        respond_with(archivelist)      
     else
        archivelist = ActiveSupport::HashWithIndifferentAccess.new
        archivelist[:success] = 1
        archivelist[:msg] = 'succesfully'
        archivelist[:data] = @listarchive
        respond_with(archivelist)
     end 
  end
  def listphotomsg
     @photomsgs = Photomsg.where(:patient_id => params[:id])  #id of the patientid id
      if @photomsgs.empty?
        photomsglist = ActiveSupport::HashWithIndifferentAccess.new
        photomsglist[:success] = 0
        photomsglist[:msg] = 'data not available'
        photomsglist[:data] = ''
        respond_with(photomsglist)     
      else
        @photomsgs = Photomsg.where(:patient_id => params[:id])  #id of the patientid id
   
      end 
  end
  def photo
    @photomsg = Photomsg.where(:photomsg_id => params[:photomsg_id])
    @photo = @photomsg.image.url
    photo = ActiveSupport::HashWithIndifferentAccess.new
        photo[:success] = 1
        photo[:msg] = 'Succesfully get data'
        photo[:data] = @photo
        respond_with(photo) 
  end
  def destroyphotomsg
    @photomsg = Photomsg.where(:photomsg_id => params[:photomsg_id], :physician => params[:physician]) 
    if @photomsg.empty?
      d_photomsg = ActiveSupport::HashWithIndifferentAccess.new
      d_photomsg[:success] = 0
      d_photomsg[:msg] = 'This photomsg is not available'
      d_photomsg[:data] = ''
      respond_with(d_photomsg)    
    else
          #@photomsg.destroy
          Photomsg.where(photomsg_id: params[:photomsg_id]).destroy_all   
          photomsg = ActiveSupport::HashWithIndifferentAccess.new
          photomsg[:success] = 1
          photomsg[:msg] = 'entry succesfully delete'
          photomsg[:data] = ''
          respond_with(photomsg)    
    end  
  end
  
  def patient_params
      params.require(:patient).permit(:d_id, :first_name, :last_name, :email, :hospitaladmin_id, :mi, :contact_no, :physician)
  end
end
