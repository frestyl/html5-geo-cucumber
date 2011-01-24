Feature: Geolocalization
  In order to use application features
  A user
  Should be able to be geolocalized

    @javascript
    Scenario: User is geolocalized
      When I go to the home page page
      And I share my location and it returns "41.8954656,12.4823243"
      Then I should see a "Location found at: 41.8954656, 12.4823243" message

    @javascript
    Scenario: User geolocalization takes too long
      When I go to the home page page
      And I share my location and it returns "timeout"
      Then I should see a "Timeout" message

    @javascript
    Scenario: User geolocalization returns an unknown location
      When I go to the home page page
      And I share my location and it returns "position unavailable"
      Then I should see a "Your Location Could Not Be Determined" message

    @javascript
    Scenario: User geolocalization returns an unknown error
      When I go to the home page page
      And I share my location and it returns "unknown error"
      Then I should see a "An Unknown Error Has Occurred" message

    @javascript
    Scenario: User denies the geolocalization
      When I go to the home page page
      And I deny to share my location
      Then I should see a "You've Turned Off Location Services" message
