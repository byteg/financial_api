class Api::V1::BalanceController < ApplicationController
  rescue_from ArgumentError do |exception|
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def show
    render json: UserSerializer.render(current_user)
  end

  def deposit
    Balance::Deposit.new(current_user, transaction_params[:amount_cents]).call
    render json: UserSerializer.render(current_user)
  end

  def withdraw
    Balance::Withdraw.new(current_user, transaction_params[:amount_cents]).call
    render json: UserSerializer.render(current_user)
  end

  def transfer
    updated_user = Balance::Transfer.new(current_user, transfer_params[:amount_cents], transfer_params[:email]).call
    render json: UserSerializer.render(updated_user)
  end

  private

  def transaction_params
    params.permit(:amount_cents)
  end

  def transfer_params
    params.permit(:amount_cents, :email)
  end
end
