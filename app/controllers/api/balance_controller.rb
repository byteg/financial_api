class Api::BalanceController < ApplicationController
  def show
    render json: UserSerializer.render(current_user)
  end

  def deposit
    Balance::Deposit.new(current_user, params[:amount_cents]).call
    render json: UserSerializer.render(current_user)
  end

  def withdraw
    Balance::Withdraw.new(current_user, params[:amount_cents]).call
    render json: UserSerializer.render(current_user)
  end
end
