class ApplicationController < ActionController::Base
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::CanCan::AccessDenied, with: :access_denied


  private
  def access_denied
    redirect_to root_path, alert: "You are not authorized to view this page"
  end

  def record_not_found
    redirect_to root_path, alert: "Record not found"
  end
end
