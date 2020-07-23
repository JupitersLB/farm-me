class SubscriptionsController < ApplicationController
  def index
    skip_policy_scope
    @subscriptions = Subscription.where(user: current_user)
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user
    @subscription.status = "pending"
    authorize @subscription

    if @subscription.save
      redirect_to subscriptions_path
    else
      @basket = Basket.find(@subscription.basket_id)
      render "/baskets/show"
    end
  end

  def update
    skip_policy_scope
    @subscription = Subscription.find(params[:id])
    authorize @subscription
    @subscription.update(subscription_params)
    @subscriptions = Subscription.where(user: current_user)
    if @subscriptions.count.zero?
      redirect_to dashboard_path
    else
      redirect_to subscriptions_path
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:status, :delivery_day, :user, :basket_id)
  end
end
