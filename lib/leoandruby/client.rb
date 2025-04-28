require "net/http"
require "json"
require "uri"

module LeoAndRuby
  class Client
    API_BASE_URL = "https://cloud.leonardo.ai/api/rest/v1".freeze

    def initialize(api_key)
      @api_key = api_key
    end

    def generate_image(prompt:, model_id:, width:, height:, num_images: 1, alchemy: nil, photo_real: nil, photo_real_strength: nil, preset_style: nil)
      uri = URI("#{API_BASE_URL}/generations")
      request = Net::HTTP::Post.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"
      request["Content-Type"] = "application/json"

      body = {
        prompt: prompt,
        modelId: model_id,
        width: width,
        height: height,
        num_images: num_images
      }
      body[:alchemy] = alchemy unless alchemy.nil?
      body[:photoReal] = photo_real unless photo_real.nil?
      body[:photoRealStrength] = photo_real_strength unless photo_real_strength.nil?
      body[:presetStyle] = preset_style unless preset_style.nil?

      request.body = body.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      handle_response(response)
    end

    def get_generation(generation_id)
      uri = URI("#{API_BASE_URL}/generations/#{generation_id}")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      handle_response(response)
    end

    def list_models
      uri = URI("#{API_BASE_URL}/platformModels")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      handle_response(response)
    end

    private

    def handle_response(response)
      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        begin
          error_body = JSON.parse(response.body)
          error_message = if error_body.is_a?(Hash)
            error_body["message"] || error_body["error"] || error_body.to_s
          else
            error_body.to_s
          end
        rescue JSON::ParserError
          error_message = response.body
        end
    
        full_error = <<~ERROR
          Leonardo.ai API Error:
          HTTP Status: #{response.code} #{response.message}
          Response Body: #{error_message}
        ERROR
    
        Rails.logger.error(full_error) if defined?(Rails)
        raise full_error.strip

      end
    end
    
  end
end
