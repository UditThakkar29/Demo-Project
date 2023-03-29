# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new
    @project = Project.friendly.find_by_slug(params[:slug]) if params[:slug]
    super
  end

  def create
    project = Project.friendly.find_by_slug(params[:user][:slug])
    flag = false
    if project
      project.users.each do |user|
        if user.email == current_user.email
          flag = true
          break
        end
      end
    end
    if not flag
      project.users << current_user
    end
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_up_path_for(resource)
    dashboard_index_path
  end
end
