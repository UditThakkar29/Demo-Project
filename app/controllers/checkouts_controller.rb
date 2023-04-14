# frozen_string_literal: true

# Controller for handling all the action related to the stripe payment
class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def create
    @session = Stripe::Checkout::Session.create({
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID} ",
      customer_email: current_user.email,
      line_items: [
        { price: 'price_1MveFuSBcixxUaoPIGm6Vseq', quantity: 1 }
      ], mode: 'subscription'
    })
    respond_to(&:js)
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])
    if @session.status == 'complete'
      # debugger
      @subscription = Stripe::Subscription.retrieve(@session.subscription)
      plan = Plan.find_by(key: @line_items.data[0].price.product)
      if current_user.subscription.nil?
        current_user.build_subscription(subscription_status: 'active', subsciption_start_date: Time.at(@subscription.current_period_start).to_date, subscription_end_date: Time.at(@subscription.current_period_end).to_date, plan_id: plan.id, subscription_key: @session.subscription).save
      else
        current_user.subscription.update(subscription_status: 'active', subsciption_start_date: Time.at(@subscription.current_period_start).to_date, subscription_end_date: Time.at(@subscription.current_period_end).to_date, plan_id: plan.id, subscription_key: @session.subscription)
      end
    end
  end
end
