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

  it 'Checks that a project can be updated' do
    @project = Project.create(name:"Project",description:"desc")
    @project.update(name: "hehe")
    expect(Project.find_by(name: "hehe")).to eq(@project)
  end

end
