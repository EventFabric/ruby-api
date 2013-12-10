require 'net/http'
require 'uri'
require 'json'

module EventFabric
    class Client
        #API Client
        def initialize(host, use_ssl = false)
            @host = host
            @cookie = nil
            @use_ssl = use_ssl
        end

        def execute(path, body)
            url = @host + path
            uri = URI.parse(url)
            initheader = {
                'Content-Type' =>'application/json',
                'Accept' =>'application/json'
            }
            if @cookie != nil
                initheader['Cookie'] = @cookie.split(";")[0]
                print initheader['Cookie']
            end
            http = Net::HTTP.new(uri.host, uri.port)
            req = Net::HTTP::Post.new(uri.request_uri, initheader)
            print "\n\n\n" + body
            req.body = body
            http.use_ssl = @use_ssl
            response = http.request(req)
            return response
        end

        def login(username, password)
            #login to the service with the specified credentials, return a tuple
            #with a boolean specifying if the login was successful and the response
            #object
            body = {
                'username' => username,
                'password' => password,
                'email' => ''
            }.to_json

            response = execute("/session", body)
            @cookie = response.response['set-cookie']
            return response
        end

        def send_event(event)
            return execute("/event", event.json())
        end
    end
end
