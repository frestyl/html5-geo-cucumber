/*
 * jQuery Location Demo – v0.0.1
 *
 * Copyright 2011, Frestyl (http://frestyl.com/)
 * Released under the MIT license
 *
 * Depends:
 *  jquery.js
 */
(function( $ ){
  $.location = {
    // window.geolocation_provider is useful for testing purposes, not used in
    // development/staging/production envs.
    geolocation_provider: window.geolocation_provider || navigator.geolocation,
    getCurrentPosition: function( options ) {
      options = $.extend({}, $.location.options, options);

      $.location.geolocation_provider.getCurrentPosition(
        $.location.success,
        $.location.error,
        options
      );
    },
    success: function( position ) {
      $(document).trigger('geo.success',
        [ position.coords.latitude, position.coords.longitude ]);
    },
    error: function( error ) {
      $(document).trigger('geo.error', [ error ]);
    },
    options: {
      timeout: 10000 // ms
    }
  }
}(jQuery));
