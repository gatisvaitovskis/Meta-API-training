Given(/^user is authorized$/) do
  authorization
  lists_locations

end

Then(/^user creates new location$/) do
  create_new_location
  retrieve_location
end

And(/^user updates location$/) do
  update_location
end

Then(/^user delete location$/) do
  delete_location
end

And(/^under list all locations$/) do
  lists_locations
end