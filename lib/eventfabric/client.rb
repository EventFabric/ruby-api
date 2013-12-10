require 'net/http'
require 'uri'
require 'json'

module EventFabric
    class Client
        #API Client
        def initialize(username, password,
                       root_url = "https://event-fabric.com/api/", use_ssl = false)
            @username = username
            @password = password
            @host = root_url.end_with?("/") ? root_url : root_url + "/"
            @cookie = nil
            @use_ssl = use_ssl
        end

        def execute(path, body)
            uri = URI.parse(endpoint(path))
            initheader = {
                'Content-Type' =>'application/json',
                'Accept' =>'application/json'
            }
            if @cookie != nil
                initheader['Cookie'] = @cookie.split(";")[0]
            end
            http = Net::HTTP.new(uri.host, uri.port)
            req = Net::HTTP::Post.new(uri.request_uri, initheader)
            req.body = body
            http.use_ssl = @use_ssl
            response = http.request(req)
            return response
        end

        def credentials
            #get credentials information
            return {
                "username" => @username,
                "password" => @password
            }
        end

        def endpoint(path)
            #return the service endpoint for path
            return @host + path
        end

        def login
            #login to the service with the specified credentials, return a tuple
            #with a boolean specifying if the login was successful and the response
            #object
            body = {
                'username' => @username,
                'password' => @password,
                'email' => ''
            }.to_json

            response = execute("session", body)
            @cookie = response.response['set-cookie']
            return response
        end

        def send_event(event)
            #send event to server, return the response object
            return execute("event", event.json)
        end
    end
end
