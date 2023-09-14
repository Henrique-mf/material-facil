class GeocodeController < ApplicationController
  skip_before_action :authenticate_user!

  def lookup
    zip_code = params[:zip_code]

    # Perform geocoding using Geocoder gem.
    results = Geocoder.search(zip_code)

    if results.empty?
      render json: { error: 'Zip code not found' }
    else
      address = results.first.address
      render json: { address: address }
    end

    # Debug output to check the response format
    puts "Geocoding Response: #{response.body}"
  end
end
