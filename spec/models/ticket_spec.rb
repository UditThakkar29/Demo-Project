require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "Associations" do
    it { should have_many(:sprint_tickets) }
    it { should have_many(:sprints).through(:sprint_tickets).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :summary }
    it { should validate_presence_of(:story_point) }
  end

  describe 'AASM states check' do
    let(:ticket) { create(:ticket) }
    it 'should have a default state of to_do' do
      expect(ticket).to have_state(:to_do)
    end

    it 'should transition from to_do to doing' do
      expect(ticket).to transition_from(:to_do).to(:doing).on_event(:start)
    end

    it 'should transition from doing to testing' do
      expect(ticket).to transition_from(:doing).to(:testing).on_event(:test)
    end

    it 'should transition from testing to done' do
      expect(ticket).to transition_from(:testing).to(:done).on_event(:done)
    end

    it 'should transition back to doing' do
      expect(ticket).to transition_from(:testing,:doing).to(:to_do).on_event(:reset)
    end

    it 'should not transition back from done to doing' do
      expect(ticket).not_to transition_from(:done).to(:to_do).on_event(:reset)
    end
  end

end
