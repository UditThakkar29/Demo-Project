require 'rails_helper'

RSpec.describe "Project", type: :request do
  let(:user) { create(:user, :manager) }
  let(:project) { create(:project) }

  before do
    user.confirm
    sign_in user
    project.users << user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get project_path(project)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get new_project_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Does not get new' do
    let(:user1) {create :user}
    before do
      user1.confirm
      sign_in user1
    end
    # it {debugger}
    let(:project) {create :project}
    it "should not get new" do
      response = get new_project_path
      expect(response).to eq(302)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get edit_project_path(project)
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested project as @project' do
      get edit_project_path(project)
      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { attributes_for(:project, name: 'New Project Name') }
      it 'updates the requested project' do
        put project_path(project), params: { project: new_attributes }
        project.reload
        expect(project.name).to eq('New Project Name')
      end
    end
  end

  describe 'DELETE #delete' do
    context 'with valid project' do
      it 'deletes the project' do
        expect do
          delete project_path(slug: project, method: :delete)
        end.to change(Project, :count).by(-1)
      end
    end
  end

  describe 'Methods' do
    context 'remove user' do
      it "removes a user from the project" do
        user_to_remove = create(:user)
        project.users << user_to_remove

        expect {
          get remove_users_project_path(slug: project.slug, user: user_to_remove.id)
        }.to change { project.reload.users.count }.by(-1)
      end
    end

    context 'invite_user' do
      let(:user_to_invite)  {create(:user)}
      it 'sends an email to the user we want to invite' do
        expect do
          post invite_user_project_path(slug: project.slug,"user"=>{"email"=>user.email})
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    # context 'cancel_subscription' do
    #   let(:plan) { create(:plan) }
    #   let(:subscription) { create(:subscription, user: user,plan: plan, subscription_end_date: 1.day.from_now) }

    #   it {debugger}
    #   it 'cancel user subscription' do
    #     expect do
    #       get cancel_subscription_project_path(slug: project.slug)
    #     end.to change(user.subscription.subscription_status).by("canceled")
    #   end
    # end

  end

  it 'Checks that a project can be updated' do
    @project = Project.create(name:"Project",description:"desc")
    @project.update(name: "hehe")
    expect(Project.find_by(name: "hehe")).to eq(@project)
  end

end
