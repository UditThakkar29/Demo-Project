require 'rails_helper'

RSpec.describe "Projects", type: :request do

  let(:user) {create :user}

  before do
    user.confirm
    sign_in user
  end

  describe 'Get new' do
    it "should be redirected as the user is not manager" do
      get new_project_path
      expect(response).to have_http_status(200)
    end
  end
end
