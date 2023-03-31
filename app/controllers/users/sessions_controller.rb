# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new
    @project = Project.friendly.find_by_slug(params[:slug]) if params[:slug]
    super
  end

  def create
    @project = Project.friendly.find_by_slug(params[:user][:slug])
    add_user_to_project
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
  def after_sign_up_path_for(_resource)
    dashboard_index_path
  end

  private

  def add_user_to_project
    flag = false
    return unless @project

    @project.users.each do |user|
      if user.email == current_user.email
        flag = true
        break
      end
    end
    @project.users << current_user unless flag
  end
end
