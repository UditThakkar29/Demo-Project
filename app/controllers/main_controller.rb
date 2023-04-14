class MainController < ApplicationController
  def index
    render layout: "home"
  end

  def after_registration_path
    confirmation_pending_path
  end
end
