require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:user) {create :user}

  before do
    sign_in user
  end

  describe 'Get new' do
    it "succeed" do
      get new_project_path
      expect(response).to have_http_status(:success)
    end
  end
end
