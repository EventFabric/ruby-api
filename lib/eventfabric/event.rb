require 'json'

module EventFabric
    class Event
        def initialize(value, channel, bucket = nil)
            @value = value
            @channel = channel
            @bucket = bucket
        end

        def json
            return {
                'channel' => @channel,
                'value' => @value
            }.to_json
        end

        def channel
            return @channel
        end

        def bucket
            return @bucket
        end

        def value_as_json
            return @value.to_json
        end
    end
end
