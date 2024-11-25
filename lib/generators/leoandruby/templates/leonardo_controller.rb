class LeonardoController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :verify_webhook_token

  def webhook
    payload = JSON.parse(request.body.read)
    # TODO: Process the incoming webhook payload
    Rails.logger.info("Received webhook: #{payload}")
    render json: {status: "success"}, status: :ok
  end

  private

  def verify_webhook_token
    provided_token = request.headers["Authorization"]&.split(" ")&.last
    expected_token = LeoAndRuby.config[:webhook_token]

    unless ActiveSupport::SecurityUtils.secure_compare(provided_token.to_s, expected_token.to_s)
      Rails.logger.warn("Unauthorized webhook attempt: #{provided_token}")
      render json: {error: "Unauthorized"}, status: :unauthorized
    end
  end
end
