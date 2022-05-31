require 'rest-client'
require 'minitest'

def prepare_auth_token
  api_key = 'test_api_key_lWPkHUdU9zn5zD993yBQ2RKjwFXBGFcf'
  @authToken = Base64.strict_encode64(":#{api_key}")
end

def create_location
  payload = {
    "name": "Riga",
    "description": "Best location on the earth",
    "latitude": 56.94,
    "longitude": 24.10,
    "meta": {
      "city": "Riga"
    }
  }
  create_location_res = post("#{@api}/locations",
                             headers: { 'Authorization' => 'Basic ' + @authToken,
                                        'content-type' => 'application/json' },
                             cookies: {},
                             payload: payload.to_json)
  assert_equal(201, create_location_res.code, 'User is not able to create location')
  location = JSON.parse(create_location_res)

  @location_id = location['data']['id']
end

def retrieve_location
  list_location_res = get("#{@api}/locations/#{@location_id}",
                          headers: { 'Authorization' => 'Basic ' + @authToken },
                          cookies: {})
  assert_equal(200, list_location_res.code, 'User is not able to get location')

  created_location = JSON.parse(list_location_res)

  @listed_id = created_location['data']['id']

  assert_equal(@location_id, @listed_id, "Fetched ID does not match requested ID")
end

def update_location
  payload = {
    "name": "Riga",
    "description": "Best location on the Earth",
    "latitude": 56.946285,
    "longitude": 24.105078,
    "meta": {
      "city": "Riga"
    }
  }

  update_location_res = put("#{@api}/locations/#{@location_id}",
                            headers: { 'Authorization' => 'Basic ' + @authToken,
                                       'content-type' => 'application/json' },
                            cookies: {},
                            payload: payload.to_json)
  assert_equal(204, update_location_res.code, 'User cannot update the location!')
end

def delete_location
  delete_location_res = delete("#{@api}/locations/#{@location_id}",
                               headers: { 'Authorization' => 'Basic ' + @authToken },
                               cookies: {})
  assert_equal(204, delete_location_res.code, 'User cannot delete the location!')

end

def list_all_locations
  list_all_locations_res = get("#{@api}/locations/?search=distance:25;latitude:56.946285;longitude:24.105078;",
                               headers: { 'Authorization' => 'Basic ' + @authToken },
                               cookies: {})
  assert_equal(200, list_all_locations_res.code, 'Locations is not listed!')

end

def retrieve_deleted_location
  list_location_res = get("#{@api}/locations/#{@location_id}",
                          headers: { 'Authorization' => 'Basic ' + @authToken },
                          cookies: {})
  assert_equal(404, list_location_res.code, 'Location is not deleted')

end