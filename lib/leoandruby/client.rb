# frozen_string_literal: true

require "net/http"
require "json"
require "uri"

module LeoAndRuby
  class Client
    API_BASE_URL = "https://cloud.leonardo.ai/api/rest/v1"
    DEFAULT_PHOTO_REAL_MODEL_ID = "aa77f04e-3eec-4034-9c07-d0f619684628"

    def initialize(api_key)
      @api_key = api_key
    end

    def generate_image(
      prompt:, height:, width:,
      model_id: nil,
      negative_prompt: nil,
      alchemy: true,
      preset_style: "DYNAMIC",
      photo_real: true,
      photo_real_version: "v2",
      num_images: 1
    )
      raise ArgumentError, "Prompt must be provided" if prompt.nil? || prompt.strip.empty?
      raise ArgumentError, "Height must be provided" if height.nil?
      raise ArgumentError, "Width must be provided" if width.nil?

      model_id ||= DEFAULT_PHOTO_REAL_MODEL_ID

      uri = URI("#{API_BASE_URL}/generations")
      request = Net::HTTP::Post.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"
      request["Content-Type"] = "application/json"

      body = {
        prompt: prompt,
        modelId: model_id,
        height: height,
        width: width,
        num_images: num_images,
        alchemy: alchemy,
        presetStyle: preset_style,
        photoReal: photo_real,
        photoRealVersion: photo_real_version
      }

      body[:negative_prompt] = negative_prompt unless negative_prompt.nil?

      request.body = body.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      handle_response(response)
    end

    def generate_image_with_user_elements(prompt:, model_id:, width:, height:, presetStyle: ,num_images: 1, promptMagic:, enhancePrompt:, user_elements:)
      uri = URI("#{API_BASE_URL}/generations")
      request = Net::HTTP::Post.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"
      request["Content-Type"] = "application/json"
    
      user_elements_data = user_elements.map do |element|
        {
          userLoraId: element[:id],
          weight: element[:weight] || 1.0
        }
      end
    
      request.body = {
        prompt: prompt,
        modelId: model_id,
        width: width,
        height: height,
        presetStyle: presetStyle,
        num_images: num_images,
        promptMagic: promptMagic,
        enhancePrompt: enhancePrompt,
        userElements: user_elements_data
      }.to_json
    
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
    
      handle_response(response)
    end
    

    def me
      uri = URI("#{API_BASE_URL}/me")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      handle_response(response)
    end

    def get_custom_elements_by_user_id(user_id)
      uri = URI("#{API_BASE_URL}/elements/user/#{user_id}")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"

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

        raise full_error.strip
      end
    end
  end
end
