require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  context 'when creating a user' do
    let(:user) {build :user}
    let(:user1) {create :user}

    it 'should be valid user with all the attributes' do
      expect(user.valid?).to eq(true)
    end

    it 'should be assigned a default role' do
      expect(user1.has_role? :user).to eq(true)
    end
  end
  describe "associations" do
    it { should have_and_belong_to_many(:projects) }
    it { should have_one(:subscription) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end
