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

  def transfer
    Balance::Transfer.new(current_user, params[:amount_cents], params[:user_id]).call
    render json: UserSerializer.render(current_user)
  end
end
