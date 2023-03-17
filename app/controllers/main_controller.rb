class MainController < ApplicationController
  def index
    render layout: "home.html.erb"
  end

  def show
  end

  def after_registration_path
    puts "######################################"
    puts "######################################"
    puts "######################################"
    puts "main controller"
    puts "######################################"
    puts "######################################"
    confirmation_pending_path
  end
end
