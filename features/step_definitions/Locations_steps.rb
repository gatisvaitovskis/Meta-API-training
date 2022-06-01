Given(/^prepare auth token$/) do
  prepare_auth_token
end

Then(/^user creates new location$/) do
  create_location
  retrieve_location
end

And(/^user updates location$/) do
  update_location
end

Then(/^user delete location/) do
  delete_location
  retrieve_deleted_location
end

Then(/^user list all locations$/) do
  list_all_locations
end
