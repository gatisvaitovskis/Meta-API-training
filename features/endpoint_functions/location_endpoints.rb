require 'rest-client'
require 'minitest'

# test_api_key_s7U4TFjwutre4GVvprAouFNt1mf56H2T

def authorization
  api_key = 'test_api_key_s7U4TFjwutre4GVvprAouFNt1mf56H2T'
  @authToken = Base64.strict_encode64(":#{api_key}")

end

def create_location
  payload = {
    "name": "Tartu",
    "description": "Best TDL Town",
    "latitude": 58.50798000,
    "longitude": 26.52480000,
    "projects": ["1e1ea71e-5908-45d0-8099-bf7afadc59dd"],
    "meta": {
      "city": "Tartu"
    },
  }

  create_location_res = post("#{@api}/locations",
                             headers: { 'Authorization' => 'Basic ' + @authToken,
                                        'content-type' => 'application/json' },
                             cookies: {},
                             payload: payload.to_json)

  assert_equal(201, create_location_res.code, 'User cannot create a location')

  create_location = JSON.parse(create_location_res)

  @location_id = create_location['data']['id']
end

def receive_location
  receive_location_res = get("#{@api}/locations/#{@location_id}",
                              headers: { 'Authorization' => 'Basic ' + @authToken,
                                         'content-type' => 'application/json' },
                              cookies: {})
  assert_equal(200, receive_location_res.code, 'Unable to receive location information OR the location does not match')
end

def update_location
  update_location_res = put("#{@api}/locations/#{@location_id}",
                            headers: { 'Authorization' => 'Basic ' + @authToken,
                                       'content-type' => 'application/json' },
                            cookies: {},
                            payload: {}.to_json)
  assert_equal(204, update_location_res.code, 'Unable to update the location')
end

def delete_location
  delete_location_res = delete("#{@api}/locations/#{@location_id}",
                               headers: { 'Authorization' => 'Basic ' + @authToken,
                                          'content-type' => 'application/json' },
                               cookies: {})
  assert_equal(204, delete_location_res.code, 'User cannot delete the location')
end

def list_all_locations
  list_locations_res = get("#{@api}/locations/",
                           headers: { 'Authorization' => 'Basic ' + @authToken },
                           cookies: {})
  assert_equal(200, list_locations_res.code, 'User is not able to get all locations')
end