require 'net/http'
require 'uri'

class Associations::RegistrationsController < Devise::RegistrationsController
  def create
    uri = URI.parse("https://siva-integ1.cegedim.cloud/apim/api-asso/api/structure")
    response = Net::HTTP.get_response(uri)
  end
end