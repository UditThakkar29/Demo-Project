class ApplicationController < ActionController::Base
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::CanCan::AccessDenied, with: :access_denied
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [:username, :phone, :email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:sign_in,
        keys: [:login, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update,
        keys: [:username, :email, :password_confirmation, :current_password])
    end

  private

  def access_denied
    redirect_to root_path, alert: "You are not authorized to view this page"
  end

  def record_not_found
    redirect_to root_path, alert: "Record not found"
  end
end
