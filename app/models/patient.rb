class Patient < ActiveRecord::Base
	belongs_to :hospitaladmin
	has_many :patientdiseases
	has_many :patientmsgs
end
