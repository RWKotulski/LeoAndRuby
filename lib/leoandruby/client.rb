require "net/http"
require "json"
require "uri"

module LeoAndRuby
  class Client
    API_BASE_URL = "https://cloud.leonardo.ai/api/rest/v1".freeze

    def initialize(api_key)
      @api_key = api_key
    end

    def generate_image(prompt:, model_id:, width:, height:, num_images: 1)
      uri = URI("#{API_BASE_URL}/generations")
      request = Net::HTTP::Post.new(uri)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"
      request["Content-Type"] = "application/json"

      request.body = {
        prompt: prompt,
        modelId: model_id,
        width: width,
        height: height,
        num_images: num_images
      }.to_json

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
        raise "HTTP Error: #{response.code} - #{response.message}"
      end
    end
  end
end
