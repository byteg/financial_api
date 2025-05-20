class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  before_action :authenticate_user!

  rescue_from ArgumentError do |exception|
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
