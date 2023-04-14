require 'rails_helper'

RSpec.describe Project, type: :model do

  describe "Associations" do
    it { should have_one(:board) }
  end

  describe 'validations' do
    subject { build(:project) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe 'after_create' do
    it 'creates a board associated with the project' do
      project = Project.create(name: 'Test', description:'temp')
      expect(project.board.valid?).to eq(true)
    end
  end

  describe 'generated_slug' do
    let(:project) { create(:project) }

    it 'should generate a slug for a new project' do
      expect(project.generated_slug).to_not be_nil
    end

    it 'should not regenerate a slug for an existing project' do
      expect(project.generated_slug).to eq project.slug
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
