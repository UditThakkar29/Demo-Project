require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:project) { FactoryBot.create(:project) }

  describe "Associations" do
    it { should belong_to(:project) }
    it { should have_many(:sprints).dependent(:destroy) }
  end

  describe 'after_create' do
    it 'creates a backlog sprint associated with the project' do
      project = Project.create(name: 'Test', description:'temp')
      expect(project.board.sprints.first.name).to eq('Backlog')
      expect(Sprint.last.backlog_sprint).to be_truthy
    end
  end

  describe 'friendly_id' do
    let(:board) { FactoryBot.create(:board) }
    it 'generates a slug when board is created' do
      expect(board.friendly_id).not_to be_nil
    end
  end

  describe 'valid board' do
    let(:board) { build :board }
    it 'should be valid board' do
      expect(board.valid?).to eq(true)
    end
  end

end
