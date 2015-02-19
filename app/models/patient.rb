class Patient < ActiveRecord::Base
	belongs_to :hospitaladmin
	has_one :patientdiseases
end
