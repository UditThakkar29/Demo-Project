# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new
    @project = Project.friendly.find_by_slug(params[:slug]) if params[:slug]
    super
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  def create
    project = Project.friendly.find_by_slug(params[:user][:slug])
    if project
      project.users << current_user if project
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
