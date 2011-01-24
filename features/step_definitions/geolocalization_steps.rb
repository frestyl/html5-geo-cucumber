When /^I share my location and it returns "([^"]*)"$/ do |coordinates|
  geolocate(coordinates)
end

Then /^I should see the "([^"]*)" as current location$/ do |location|
  match_geolocalization_message(location)
end

Then /^I should see a "([^"]*)" message$/ do |message|
  match_geolocalization_message(message)
end

When /^I deny to share my location$/ do
  geolocate('permission denied')
end

module GeolocalizationHelpers
  def geolocate(result)
    case result
    when "timeout", "permission denied", "position unavailable", "unknown error":
      page.execute_script "state = '#{result.gsub(' ', '_')}';"
    else
      localize_at(result)
    end
  end

  def match_geolocalization_message(message)
    sleep 0.1
    page.body.should match(/#{message}/)
  end

  def localize_at(coordinates)
    latitude, longitude = coordinates.split(',')
    page.execute_script "latitude = '#{latitude}'; longitude = '#{longitude}';"
    page.execute_script "state = 'ok';"
  end
end

World(GeolocalizationHelpers)