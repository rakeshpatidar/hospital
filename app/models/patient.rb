class Patient < ActiveRecord::Base
	belongs_to :hospitaladmin
	has_many :patientdiseases
end
