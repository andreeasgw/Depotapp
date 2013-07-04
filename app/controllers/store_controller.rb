class StoreController < ApplicationController
 skip_before_filter :authorize
 before_filter :set_i18n_locale_from_params 
 def index
     if params[:set_locale]
        redirect_to store_path(locale: params[:set_locale])
      else
	@products = Product.order(:title)
	@cart = current_cart
        @count = increment
       end 
  end
  
  
end
