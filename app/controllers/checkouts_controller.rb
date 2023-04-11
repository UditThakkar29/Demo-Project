class CheckoutsController < ApplicationController
  before_action :authenticate_user!


  def create
    # current_user.set_payment_processor :stripe
    # current_user.payment_processor.customer

    # @checkout_session = current_user
    #     .payment_processor
    #     .checkout(
    #       mode: 'subscription',
    #       line_items: 'price_1MveFuSBcixxUaoPIGm6Vseq',
    #       success_url: checkout_success_url
    #     )
    @session = Stripe::Checkout::Session.create({
      success_url: checkout_success_url,
      customer_email: current_user.email,
      line_items: [
        {price: 'price_1MveFuSBcixxUaoPIGm6Vseq', quantity: 1},
      ],
      mode: 'subscription',
    })
    respond_to do |format|
      format.js
    end

  end

  def success
    debugger
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])

  end
end
