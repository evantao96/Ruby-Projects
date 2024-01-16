class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method def logged_in?
    session[:user_id]
  end

  helper_method def current_user
    unless logged_in?
      redirect_to root_url
    else
      User.find(session[:user_id])
    end
  end
end
