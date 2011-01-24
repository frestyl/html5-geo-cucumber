var Geolocation = function( ) {
  var self = this;

  self.errors = {
    TIMEOUT: 1,
    POSITION_UNAVAILABLE: 2,
    PERMISSION_DENIED: 3,
    UNKNOWN_ERROR: 4
  };

  self.getCurrentPosition = function( success, error, options ) {
    // simulate the wait for the user choice
    var geoIntervalId = window.setInterval(function( ) {
      if ( state != null ) {
        window.clearInterval(geoIntervalId);

        switch( state ) {
          case 'ok':
            success(new Position(latitude, longitude));
            break;
          case 'timeout': case 'position_unavailable': case 'permission_denied':
            error( new GeolocationError( self.errors[state.toUpperCase()] ) );
            break;
          default:
            error( new GeolocationError( self.errors.UNKNOWN_ERROR ) );
        }
      }
    }, 100); // ms
  };
}

var Position = function( lat, lng ) {
  this.coords = new Coordinates(lat, lng);
}

var Coordinates = function( lat, lng ) {
  this.latitude  = lat;
  this.longitude = lng;
}

var GeolocationError = function( code ) {
  this.TIMEOUT = 1;
  this.POSITION_UNAVAILABLE = 2;
  this.PERMISSION_DENIED = 3;
  this.UNKNOWN_ERROR = 4;

  this.code = code;
}

var state     = null,
    latitude  = null,
    longitude = null;

window.geolocation_provider = new Geolocation();