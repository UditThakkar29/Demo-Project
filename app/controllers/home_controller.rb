class HomeController < ApplicationController
  before_action :authenticate_user!
  def index

  end

  def project
    
  end

  def after_sign_up_path_for(resource)
    home_index_path
  end
end
