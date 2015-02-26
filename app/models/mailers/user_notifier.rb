class UserNotifier < ApplicationMailer
	default from: "rakeshpatidar71@gmail.com"

	def send_doctor_email(user)
    	@user = user
    	mail( :to => @user.email, :subject => 'Your login details for COORDI-CARE app' )
  	end


end
