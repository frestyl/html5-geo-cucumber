module Rack
  module Geo
    class JavascriptInjector
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)

        if inject?(status, headers, response)
          response.body = response.body.gsub(/\<head\>/, %(<head>\n<script type="text/javascript" charset="utf-8">\n#{javascript}\n</script>))
        end

        [ status, headers, response ]
      end

      protected
        # Entry point to decide if the javascript code should be injected into the response.
        #
        # For instance you may want to avoid sending code unless the 'Content-Type'
        # is set to 'text/html'.
        #
        # NOTE: Rails 3 has a built-in Conditional GET mechanism, so for the first
        # time the <tt>status</tt> is <tt>200</tt> and the <tt>Content-Type</tt> is
        # set to <tt>text/html; charset=utf-8</tt> and the <tt>response</tt> is an
        # <tt>ActionDispatch::Response</tt> instance.
        # For the subsequent requests it will probably return a <tt>304 (Not Modified)</tt>
        # with no headers set and <tt>response</tt> will be an <tt>Array</tt>.
        def inject?(status, headers, response)
          status == 200 && /text\/html/.match(headers['Content-Type'])
        end

        def javascript
          @javascript ||= ::File.read(::File.dirname(__FILE__) + '/navigator_geolocation.js')
        end
    end
  end
end