class Api::BalanceController < ApplicationController
  def show
    render json: UserSerializer.render(current_user)
  end
end
