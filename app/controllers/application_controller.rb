class ApplicationController < ActionController::Base
  protected

  def after_sign_up_path_for(_resource)
    new_user_session_path
  end
end
