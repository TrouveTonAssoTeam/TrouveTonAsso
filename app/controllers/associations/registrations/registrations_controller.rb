require 'net/http'
require 'uri'

class Associations::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      unless api_key_valid?(resource.api_key)
        resource.errors.add(:api_key, "Invalid API key")
        clean_up_passwords(resource)
        respond_with_navigational(resource) { render :new }
        return
      end
    end
  end

  private

  def api_key_valid?(api_key)
    uri = URI.parse("https://www.data.gouv.fr")  # Remplacez "URL_DE_L_API_DATA_GOUV" par l'URL de l'API Data.gouv
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'

    request = Net::HTTP::Get.new(uri.request_uri)
    request['Authorization'] = "Bearer #{api_key}"  # Ajoutez l'en-tête d'autorisation avec la clé API

    response = http.request(request)

    # Vérifiez le code de réponse pour déterminer si la clé est valide
    response.code == '200'  # Retourne true si la clé est valide, sinon false
  rescue StandardError => e
    puts "Erreur lors de la validation de la clé API : #{e.message}"
  return false
  end
end