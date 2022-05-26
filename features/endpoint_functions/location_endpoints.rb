require 'rest-client'
require 'minitest'

# test_api_key_Xm5TSJTWS7mNy9QFYC6ukWOXUvyItsIZ

def authorization
  api_key = 'test_api_key_Xm5TSJTWS7mNy9QFYC6ukWOXUvyItsIZ'

  @authToken = Base64.strict_encode64(":#{api_key}")

end

def create_new_location
  payload = {
    "name": "riga",
    "description": "workplace",
    "latitude": 2,
    "longitude": 2
  }
  create_new_location_res = post('https://api.timekit.io/v2/locations',
                                 headers: { 'Authorization' => 'Basic ' + @authToken,
                                            'content-type' => 'application/json' },
                                 cookies: {},
                                 payload: payload.to_json)

  assert_equal(201, create_new_location_res.code, 'User is not able to create location')

end

def retrieve_location
  retrieve_location_res = get("https://api.timekit.io/v2/locations/#{@location_ids[0]}",
                              headers: { 'Authorization' => 'Basic ' + @authToken,
                                        'content-type' => 'application/json' },
                              cookies: {})
  assert_equal(200, retrieve_location_res.code, 'Can not retrieve location')
  retrieved = JSON.parse(retrieve_location_res)

  @retrvedied_ids = []
  @retrvedied_ids.append(retrieved['data'].fetch("id"))



  assert_equal(true, @location_ids[0] == @retrvedied_ids[0], 'Ids do not match')

end

def lists_locations
  lists_locations_res = get('https://api.timekit.io/v2/locations',
                            headers: { 'Authorization' => 'Basic ' + @authToken },
                            cookies: {})
  assert_equal(200, lists_locations_res.code, 'User is not able to list locations')

  resources = JSON.parse(lists_locations_res)

  @location_ids = []
  resources['data'].each do |find_data_in_array|
    @location_ids << find_data_in_array['id']
  end

end

def update_location
  payload = {
    "name": "Ventspils",
    "description": "Other workplace",
    "latitude": 1,
    "longitude": 1
  }
  update_location_res = put("https://api.timekit.io/v2/locations/#{@location_ids[0]}",
                            headers: { 'Authorization' => 'Basic ' + @authToken,
                                       'content-type' => 'application/json' },
                            cookies: {},
                            payload: payload.to_json)

  assert_equal(204, update_location_res.code, 'Can not update location')

end

def delete_location
  delete_location_res = delete("https://api.timekit.io/v2/locations/#{@location_ids[0]}",
                               headers: { 'Authorization' => 'Basic ' + @authToken,
                                          'content-type' => 'application/json' },
                               cookies: {})

  assert_equal(204, delete_location_res.code, 'Can not delete location') # in documentation was 200. 204 made more sense

end