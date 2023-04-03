require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) {create :user}

  before do
    user.confirm
    login_as user
  end

  context 'when creating a user' do
    let(:project) {create :project}
    it 'should be valid project with all the attributes' do
      expect(project.valid?).to eq(true)
    end
  end
end
