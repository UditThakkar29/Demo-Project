class InvitationsController < ApplicationController
   skip_before_action :authenticate_user!, only: :new
  def new
    if user_signed_in?
      create
    else
      redirect_to new_user_registration_path(slug: params[:project_slug])
    end
  end

  def create
    @project = Project.friendly.find_by_slug(params[:project_slug])
    flag = false
    @project.users.each do |user|
      if user.email == current_user.email
        flag = true
        break
      end
    end
    @project.users << current_user if flag == false
    redirect_to @project
  end
end
