require 'rails_helper'

RSpec.describe "Invitations", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  describe "GET #new" do
    context 'user signed in' do
      before do
        user.confirm
        login_as user
      end
      it "creates the user and redirects to the project page" do
        get new_project_invitation_path(project_slug: project.slug)
        expect(response).to redirect_to(project_path(project))
      end
      it 'add user to the project' do
        get new_project_invitation_path(project_slug: project.slug)
        expect(project.reload.users).to include(user)
      end
    end

    context "when user is not signed in" do
      it "redirects to the registration page with the project slug" do
        get new_project_invitation_path(project_slug: project.slug)

        expect(response).to redirect_to(new_user_registration_path(slug: project.slug))
      end
    end
  end

  describe 'POST #create' do
    context "when the user is already a member of the project" do
      before do
        user.confirm
        login_as user
        project.users << user
      end

      it "does not add the user to the project and redirects to the project page" do
        expect {
          post project_invitations_path(project_slug: project.slug)
        }.to_not change(project.users, :count)

        expect(response).to redirect_to(project_path(project))
      end
    end

    context "when the user is not a member of the project" do
      before do
        user.confirm
        login_as user
        sign_in user
      end

      it "adds the user to the project and redirects to the project page" do
        expect {
          post project_invitations_path(project_slug: project.slug)
        }.to change(project.users, :count).by(1)

        expect(response).to redirect_to(project_path(project))
        expect(project.reload.users).to include(user)
      end
    end

  end

end
