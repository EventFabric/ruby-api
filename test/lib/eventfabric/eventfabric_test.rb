require_relative '../../test_helper'

describe EventFabric do

    it "login and send event" do
        client = EventFabric::Client.new("http://event-fabric.com/api")
        response = client.login("your_username", "your_password")
        response.code.must_equal("201")
        event = EventFabric::Event.new({
            "text" => "CPU",
            "percentage" => 80
        }, "your_channel")
        response = client.send_event(event);
        response.code.must_equal("201")
    end

end
