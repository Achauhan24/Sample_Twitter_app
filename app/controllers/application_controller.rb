class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

   def logged_in_customer
    unless logged_in?
      flash[:danger]="Please log in"
      redirect_to login_url
    end
  end
end
