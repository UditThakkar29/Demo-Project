require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "Associations" do
    it { should belong_to(:project) }
    it { should have_many(:sprints).dependent(:destroy) }
  end

  describe 'after_create' do
    it 'creates a backlog sprint associated with the project' do
      project = Project.create(name: 'Test', description:'temp')
      expect(project.board.sprints.first.name).to eq('Backlog')
    end
  end

  describe 'valid board' do
    let(:board) { build :board }
    it 'should be valid board' do
      expect(board.valid?).to eq(true)
    end
  end

end
