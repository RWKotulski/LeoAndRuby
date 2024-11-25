class LeonardoController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    payload = JSON.parse(request.body.read)
    # TODO: Process the incoming webhook payload
    Rails.logger.info("Received webhook: #{payload}")
    render json: { status: 'success' }, status: :ok
  end
end
