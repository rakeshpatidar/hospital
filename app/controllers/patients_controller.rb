class PatientsController < ApplicationController
  before_action :authenticate_hospitaladmin!
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :patientlist, :discharge]

  respond_to :html, :json

  def index
    @patients = @patients = current_hospitaladmin.patients.where(:discharge_status => 0)
    respond_with(@patients1)
  end

  def show
    @patient = Patient.find(params[:id])
    respond_with(@patient)
  end

  def new
    @patient = current_hospitaladmin.patients.new
    respond_with(@patient)
  end

  def edit
  end

  def create
    @patient = current_hospitaladmin.patients.new(patient_params)
    @patient.hospitaladmin_id = current_hospitaladmin.id
    @patient.discharge_status = 0
    @patient.save
    respond_with(@patient)
  end

  def update
    @patient.update(patient_params)
    respond_with(@patient)
  end

  def discharge
    
  end

  def destroy
    @patient.destroy
    respond_with(@patient)
  end

  #private
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :email, :gender, :mi, :date_of_birth, :contact_no, :billing_id, :physician)
    end
end
#name=test&gender=male&date_of_birth=10/02/2010&contact_no=58475896&billing_id=25&physician=48