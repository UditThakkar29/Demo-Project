require 'rails_helper'

RSpec.describe "Project", type: :request do

  let(:user) {create :user, :manager}

  before do
    user.confirm
    sign_in user
  end
  before(:all) do
    @project = Project.create(name:"Project",description:"desc")
  end

  describe 'Get new' do
    it "should ghet new" do
      get new_project_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Does not get new' do
    let(:user1) {create :user}
    before do
      user1.confirm
      sign_in user1
    end
    let(:project) {create :project}
    it "should not get new" do
      response = get new_project_path
      expect(response).to eq(302)
      expect {
        get new_project_path
      }.to eq(:success)
    end
  end

  it 'Checks that a project can be updated' do
    @project.update(name: "hehe")
    expect(Project.find_by(name: "hehe")).to eq(@project)
  end

end
