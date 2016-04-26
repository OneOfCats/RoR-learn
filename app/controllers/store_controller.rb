class StoreController < ApplicationController

  helper_method :show_counter

  def index
  	@products = Product.order(:title)
  	if session[:counter].nil?
	  session[:counter] = 0
	else
	  session[:counter] += 1
	end
	@cnt = session[:counter]
  end
 
end
