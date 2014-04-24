class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :set_layout

  def set_layout
    if user_signed_in?
      'authenticated'
    else
      'guest'
    end
  end
  
end
