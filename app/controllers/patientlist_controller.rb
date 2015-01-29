class ApiController < ApplicationController
  respond_to :json
  def patient
   @patients = Patient.all
     respond_with(@patients)
  end
    def disease
   @diseasecode = Diseasecode.all
     respond_with(@diseasecode)
  end
end
