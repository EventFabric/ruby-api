require_relative '../../test_helper'

describe EventFabric do
    username = "javierdallamore"
    password = "apache"
    client = EventFabric::Client.new(username, password, "http://event-fabric.com/api/")
    event = EventFabric::Event.new({
        "text" => "CPU",
        "percentage" => 80
    }, "your_channel")

    it "login" do
        response = client.login
        response.code.must_equal("201")
    end

    it "endpoint" do
        client.endpoint("event").must_equal("http://event-fabric.com/api/event")
    end

    it "credentials" do
        credentials = client.credentials
        credentials["username"].must_equal(username)
        credentials["password"].must_equal(password)
    end

    it "event as json" do
        event.json.must_equal("{\"channel\":\"your_channel\",\"value\":{\"text\":\"CPU\",\"percentage\":80}}")
    end

    it "send event" do
        response = client.send_event(event);
        response.code.must_equal("201")
    end


end
