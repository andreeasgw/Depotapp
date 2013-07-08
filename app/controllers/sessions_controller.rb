class SessionsController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :set_i18n_locale_from_params
 
 def new
  end

#  def create
#	user = User.find_by_name(params[:name])
#	if user and user.authenticate(params[:password])
#	   session[:user_id] = user.id
#	   redirect_to admin_url
#	else
#	    redirect_to login_url, alert: "Invalid user/password combination"
#	end
#  end

  def destroy
    session[:user_id] = nil
     redirect_to store_url, notice: "Logged out"
  end

#first attempt
  def create
	auth = request.env["omniauth.auth"]
	user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
	session[:user_id] = user.id
	redirect_to store_url, :notice =>"Signed in!"
  end

# def destroy 
#	session[:user_id] = nil
#	redirect to login_url, :notice => "Signed out!"
 # end
end
