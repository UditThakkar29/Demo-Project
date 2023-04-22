require 'rails_helper'

RSpec.describe "Mains", type: :request do
  describe "GET /mains" do
    it "GET #index" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
