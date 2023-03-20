class HomeController < ApplicationController
  before_action :authenticate_user!
  layout "application.html.erb"
  def index
  end

  def after_sign_up_path_for(resource)
    home_index_path
  end
end
