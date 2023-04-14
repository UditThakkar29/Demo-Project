require 'rails_helper'

RSpec.describe Sprint, type: :model do
  describe "Associations" do
    it { should belong_to(:board) }
    it { should have_many(:sprint_tickets).dependent(:destroy) }
    it { should have_many(:tickets).through(:sprint_tickets) }
    it { should have_one_attached(:image) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :start_time }
    it { is_expected.to validate_presence_of :goal }
  end

  describe 'Scope tests' do
    it 'is current sprint' do
      sprint = create(:sprint,current_sprint: true)
      expect(Sprint.current_sprint).to include(sprint)
    end
    it 'is not current sprint' do
      sprint = create(:sprint)
      expect(Sprint.current_sprint).to_not include(sprint)
    end
    it 'is backlog sprint' do
      sprint = create(:sprint,backlog_sprint: true)
      expect(Sprint.backlog_sprint).to include(sprint)
    end
    it 'is not backlog sprint' do
      sprint = create(:sprint)
      expect(Sprint.backlog_sprint).to_not include(sprint)
    end
  end

end
