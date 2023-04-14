# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Boards', type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  before do
    user.confirm
    login_as user
    project.users << user
  end

  describe 'GET #index' do
    it 'should get boards index' do
      get project_boards_path(project)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'should get the show page' do
      get project_board_path(project_slug: project, slug: project.board)
      expect(response).to have_http_status(200)
    end
  end
end
