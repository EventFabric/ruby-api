require 'json'

module EventFabric
    class Event
        def initialize(value, channel)
            @value = value
            @channel = channel
        end

        def json()
            return {
                'channel' => @channel,
                'value' => @value
            }.to_json
        end
    end
end
