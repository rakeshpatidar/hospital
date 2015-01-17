class HospitaladminController < ApplicationController
  def index
  	@doctors = current_hospitaladmin.doctors.all
  	@patients = current_hospitaladmin.patients.all
  end
end
