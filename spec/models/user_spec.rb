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

  describe "#active_subscription?" do
    let(:user) { create(:user) }
    let(:plan) { create(:plan) }

    before do
      user.confirm
      login_as user
    end

    context "when the user has an active subscription" do
      let(:subscription) { create(:subscription, user: user,plan: plan, subscription_end_date: 1.day.from_now) }

      before do
        allow(user).to receive(:subscription).and_return(subscription)
      end

      it "returns true" do
        expect(user.active_subscription?).to eq(true)
      end
    end

    context "when the user does not have a subscription" do
      before do
        allow(user).to receive(:subscription).and_return(nil)
      end
      it "returns false" do
        expect(user.active_subscription?).to eq(false)
      end
    end

    context "when the user's subscription has ended" do
      let(:subscription) { create(:subscription, user: user,plan: plan, subscription_end_date: 1.day.ago) }

      before do
        allow(user).to receive(:subscription).and_return(subscription)
      end

      it "checks the subscription status and updates the subscription end date" do
        expect(user).to receive(:check_subsciption_status)
        expect(user.active_subscription?).to eq(false)
        expect(user.subscription.subscription_end_date.to_date).to eq(subscription.subscription_end_date.to_date)
      end
    end
  end
end
