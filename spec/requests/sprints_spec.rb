require 'rails_helper'

RSpec.describe "Sprints", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:board) { project.board }

  before do
    user.confirm
    login_as user
    project.users << user
  end

  describe 'GET #show' do
    let(:sprint) { create(:sprint, board: board) }
    it 'should get show' do
      get project_board_sprint_path(slug: sprint,board_slug: board, project_slug: project)
      expect(response).to have_http_status(200)
    end

    it 'assigns the requested sprint as @sprint' do
      get project_board_sprint_path(slug: sprint,board_slug: board, project_slug: project)
      expect(assigns(:sprint)).to eq(sprint)
    end
  end

  describe 'GET #new' do
    it 'should get new' do
      get new_project_board_sprint_path(board_slug: board, project_slug: project)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Sprint' do
        expect do
          post project_board_sprints_path(board_slug: board, project_slug: project, sprint: attributes_for(:sprint))
        end.to change(Sprint, :count).by(1)
      end

      it 'assigns a newly created sprint to @sprint' do
        post project_board_sprints_path(board_slug: board, project_slug: project, sprint: attributes_for(:sprint))
        expect(assigns(:sprint)).to be_a(Sprint)
        expect(assigns(:sprint)).to be_persisted
      end

      it 'redirects to the created sprint' do
        post project_board_sprints_path(board_slug: board, project_slug: project, sprint: attributes_for(:sprint))
        expect(response).to redirect_to project_board_sprint_path(slug: Sprint.last,board_slug: board, project_slug: project)
      end
    end
    context 'with invalid params' do
      it 'does not save just assigns' do
        post project_board_sprints_path(board_slug: board, project_slug: project, sprint: attributes_for(:sprint,name: nil))
        expect(assigns(:sprint)).to be_a_new(Sprint)
      end

      it 're-renders the new template' do
        post project_board_sprints_path(board_slug: board, project_slug: project, sprint: attributes_for(:sprint,name: nil))
        expect(response).to render_template(:new)
      end
    end
  end
end
