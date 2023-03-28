class Users::RegistrationsController < Devise::RegistrationsController
  layout "home.html.erb"

  def new
    @project = Project.friendly.find_by_slug(params[:slug]) if params[:slug]
    super
  end

  def create
    super
    if resource.save && params[:user].key?(:slug)
      project = Project.friendly.find_by_slug(params[:user][:slug])
      if project != nil
        project.users << resource
      end
    end
  end

  def after_inactive_sign_up_path_for(resource)
    puts "######################"
    puts "######################"
    puts "registration controller"
    puts "######################"
    puts "######################"
    "/confirmation_pending"
  end
end
# frozen_string_literal: true

# class Users::RegistrationsController < Devise::RegistrationsController
#   # before_action :configure_sign_up_params, only: [:create]
#   # before_action :configure_account_update_params, only: [:update]

#   # GET /resource/sign_up
#   # def new
#   #   super
#   # end

#   # POST /resource
#   # def create
#   #   super
#   # end

#   # GET /resource/edit
#   # def edit
#   #   super
#   # end

#   # PUT /resource
#   # def update
#   #   super
#   # end

#   # DELETE /resource
#   # def destroy
#   #   super
#   # end

#   # GET /resource/cancel
#   # Forces the session data which is usually expired after sign
#   # in to be expired now. This is useful if the user wants to
#   # cancel oauth signing in/up in the middle of the process,
#   # removing all OAuth session data.
#   # def cancel
#   #   super
#   # end

#   # protected

#   # If you have extra params to permit, append them to the sanitizer.
#   # def configure_sign_up_params
#   #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
#   # end

#   # If you have extra params to permit, append them to the sanitizer.
#   # def configure_account_update_params
#   #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
#   # end

#   # The path used after sign up.
#   # def after_sign_up_path_for(resource)
#   #   super(resource)
#   # end

#   # The path used after sign up for inactive accounts.
#   def after_inactive_sign_up_path_for(resource)
#   end
# end
