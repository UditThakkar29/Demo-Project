require 'rails_helper'

RSpec.describe Project, type: :model do

  describe "Associations" do
    it { should have_one(:board) }
  end

  describe 'after_create' do
    it 'creates a board associated with the project' do
      project = Project.create(name: 'Test', description:'temp')
      expect(project.board.valid?).to eq(true)
    end
  end

  let(:user) {create :user}

  before do
    user.confirm
    login_as user
  end

  context 'when creating a project' do
    let(:project) {create :project}
    it 'should be valid project with all the attributes' do
      expect(project.valid?).to eq(true)
    end
  end
end
