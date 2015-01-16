class WelcomeController < ApplicationController
 
  def index

  	if admin_signed_in? 
  		redirect_to url_for(:controller => :dashboards, :action => :index)
   	else
   		if hospitaladmin_signed_in? 
  			redirect_to url_for(:controller => :hospitaladmin, :action => :index)
   		else
   			redirect_to new_hospitaladmin_session_path
   		end
   	end

   		

  end

end
