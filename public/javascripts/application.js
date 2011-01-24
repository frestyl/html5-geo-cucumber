/*
 * application.js – v0.0.1
 *
 * Copyright 2011, Frestyl (http://frestyl.com/)
 * Released under the MIT license
 *
 * Depends:
 *  jquery.js
 *  jquery.location.js
 */
(function( $ ){
  $(document).ready(function( ) {
    $(document).bind('geo.success', function( event, latitude, longitude ){
      $("#message").text('Location found at: ' + latitude + ', ' + longitude);
      map.setCenter(new google.maps.LatLng(parseFloat(latitude), parseFloat(longitude)));
      map.setZoom(14);
    });

    $(document).bind('geo.error', function( event, error ){
      var message;

      switch(error.code) {
        case error.TIMEOUT:
          message = "Timeout";
          break;
        case error.POSITION_UNAVAILABLE:
          message = "Your Location Could Not Be Determined";
          break;
        case error.PERMISSION_DENIED:
          message = "You've Turned Off Location Services";
          break;
        case error.UNKNOWN_ERROR:
          message = "An Unknown Error Has Occurred";
          break;
      }

      $("#message").text(message);
    });

    var center  = new google.maps.LatLng(0.0, 0.0);
    var options = {
      zoom: 2,
      center: center,
      mapTypeControlOptions: { mapTypeIds: [ ] },
      mapTypeId: "roadmap"
    };
    var map = new google.maps.Map(document.getElementById("map"), options);

    $.location.getCurrentPosition();
  });
}(jQuery));