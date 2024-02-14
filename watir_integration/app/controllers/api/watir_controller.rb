# app/controllers/api/watir_controller.rb
module Api
  class WatirController < ApplicationController
    # protect_from_forgery with: :null_session # Skip CSRF protection for API requests
    # protect_from_forgery unless: -> { request.format.json? }
    include ActionController::RequestForgeryProtection

    protect_from_forgery with: :null_session

    def receive_data
      variable = params[:variable]
      # Process the variable as needed
      render json: { message: "Received variable: #{variable}" }
    end
  end
end

