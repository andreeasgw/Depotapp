class ApplicationController < ActionController::Base
 # before_filter :set_i18n_locale_from_params, :except => {:sessions=>:create }
  #before_filter :authorize
  before_filter :conf
  protect_from_forgery
  helper_method :current_user 
  
private
  def current_cart
	Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
	cart = Cart.create
	session[:cart_id] = cart.id
	cart
   end
  
  def current_user
	@current_user ||= User.find(session[:user_id]) if session [:user_id]
  end
  protected

    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
	if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
           flash.now[:notice] = "#{params[:locale]} translation not available"
       	  logger.error flash.now[:notice]
          
        end
       end
     end
    def default_url_options
	{ locale: I18n.locale }
    end
   
   def conf
	  token = session[:token]
          secret = session[:secret]
        Twitter.configure do |config|
        config.consumer_key =  'DzliyAsaZHH0Of5kIcPGvQ'
        config.consumer_secret = 'XW17gQS2wIpwRGryFiL0zBYFFL4ZrqeBpcte5oi4'
        config.oauth_token = token #'1544574674-fKXHqwOcU3oSmNhRXVZONIKgdUvoGUnqZSFETP6'
        config.oauth_token_secret =secret #'YOTrfmJZzVf80fM9pQ3mBEP9Nw66o4o4KAvDWPOcOQ'
     end
   end
  def increment
        if session[:counter].nil?
          session[:counter]=0
        end
        session[:counter] +=1
      # if session[:counter] > 2
       #   return session[:counter]
      # end
  end
 
  def reset_session
	if not session[:counter].nil?
         session[:counter] = 0
         end
   end
end
