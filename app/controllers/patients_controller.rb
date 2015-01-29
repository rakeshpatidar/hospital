class PatientsController < ApplicationController
  before_action :authenticate_hospitaladmin!
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :patientlist]

  respond_to :html, :json

  def index
    @patients = current_hospitaladmin.patients.all
    @patients1 = Patient.all
    respond_with(@patients1)
  end

  def show
    respond_with(@patient)
    @article = Patient.find(params[:id])
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
    @patient.save
    respond_with(@patient)
  end

  def update
    @patient.update(patient_params)
    respond_with(@patient)
  end

  def destroy
    @patient.destroy
    respond_with(@patient)
  end

  private
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def patient_params
      params.require(:patient).permit(:name, :gender, :date_of_birth, :contact_no, :billing_id, :physician)
    end
end
