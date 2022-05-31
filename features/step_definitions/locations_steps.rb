Given(/^user is authorized$/) do
  authorization
end

Then(/^user creates new location$/) do
  create_location
  receive_location
end

And(/^user updates location$/) do
  update_location
end

Then(/^user delete location$/) do
  delete_location
end

And(/^user list all locations$/) do
  list_all_locations
end