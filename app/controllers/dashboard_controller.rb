class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout "application"
  def index
  end

  def after_sign_up_path_for(resource)
    dashboard_index_path
  end
end
