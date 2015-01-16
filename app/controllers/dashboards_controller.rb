class DashboardsController < ApplicationController
	def index
		@hospitals = Hospitaladmin.all
	end
end
