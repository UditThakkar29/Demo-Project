class RegistrationsController < Devise::RegistrationsController
  # layout "home.html.erb"

  # def new
  #   super
  #   render
  # end

  def after_inactive_sign_up_path_for(resource)
      puts "######################"
      puts "######################"
      puts "registration controller"
      puts "######################"
      puts "######################"
      "/confirmation_pending"
  end



end
