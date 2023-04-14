class RegistrationsController < Devise::RegistrationsController
  layout "home.html.erb"
  def after_inactive_sign_up_path_for(resource)
      "/confirmation_pending"
  end
end
