class HospitaladminController < ApplicationController
  def index
  	@doctors = Doctor.all
  	@patients = current_hospitaladmin.patients.all
  end
end
