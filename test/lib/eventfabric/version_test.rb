require_relative '../../test_helper'

describe EventFabric do

    it "must be defined" do
        EventFabric::VERSION.wont_be_nil
    end

end
