require_relative '../../test_helper'

describe EventFabric do
    username = "admin"
    password = "secret"
    client = EventFabric::Client.new(username, password,
                                     "http://localhost:8080/")
    event = EventFabric::Event.new({
        "text" => "cpu",
        "percentage" => 80
    }, "my.channel")

    it "login" do
        response = client.login
        response.code.must_equal("201")
    end

    it "endpoint" do
        client.endpoint("streams").must_equal("http://localhost:8080/streams")
    end

    it "credentials" do
        credentials = client.credentials
        credentials["username"].must_equal(username)
        credentials["password"].must_equal(password)
    end

    it "event as json" do
        event.json.must_equal("{\"channel\":\"my.channel\",\"value\":{\"text\":\"cpu\",\"percentage\":80}}")
    end

    it "send event" do
        response = client.send_event(event);
        response.code.must_equal("201")
    end
end
