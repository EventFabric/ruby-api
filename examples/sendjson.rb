#!/usr/bin/env ruby

#example using eventfabric api client library to send an arbitrary json
#file as an event
require 'optparse'
require 'eventfabric'
require 'ostruct'
require 'json'
require 'pp'

def parse_args(args)
    #parse and return command line arguments
    options = OpenStruct.new
    options.username = ""
    options.password = ""
    options.channel = ""
    options.path = ""
    options.url = ""

    opt_parser = OptionParser.new do |opt|
        opt.banner = "Usage: ruby sendjson.rb [OPTIONS]"
        opt.separator  ""
        opt.separator  "Options"

        opt.on("-u", "--username USERNAME", "Username to authenticate to Event Fabric") do |username|
            options.username << username
        end

        opt.on("-p", "--password PASSWORD", "Password to authenticate to Event Fabric") do |password|
            options.password << password
        end

        opt.on("-c", "--channel CHANNEL", "Channel used in the generated event") do |channel|
            options.channel << channel
        end

        opt.on("-P", "--path PATH", "Path to the JSON file you want to send") do |path|
            options.path << path
        end

        opt.on("-U", "--url URL", "URL for Event Fabric API") do |url|
            options.url = url || "https://event-fabric.com/ef/api/"
        end
        opt.on("-h", "--help", "help") do
            puts opt_parser
            return nil
        end
    end

    opt_parser.parse!(args)

    options
end

def main
    #main program entry point
    args = parse_args(ARGV)

    if args == nil
        return
    end

    pp "Config:", args.username, args.password, args.channel, args.path, args.url

    client = EventFabric::Client.new(args.username, args.password, args.url)
    begin
        login_response = client.login

        if login_response.code != "201"
            pp "Error authenticating", login_response
            return
        end

        begin
            file = open(args.path)
            json = file.read
            value = JSON.parse(json)
        rescue Exception => error
            pp "Error opening file", args.path, error
            return
        end

        event = EventFabric::Event.new(value, args.channel)
        send_response = client.send_event(event)
        pp "Send Event:", event.json

        if send_response.code != "201"
            pp "Error sending event", send_response
            return
        end


        rescue Exception => conn_error
            pp "Error connection to server", args.url, conn_error
            return
        end
    end

$end

if __FILE__ == $PROGRAM_NAME
    main
end
