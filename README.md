Event Fabric API Client
=======================

Ruby implementation of Event Fabric API to send events.

Setup
-----

Add this line to your application's Gemfile:

    gem 'eventfabric'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eventfabric

Usage
-----

see the tests or examples folder for more usage examples

::

    client = EventFabric::Client.new("http://event-fabric.com/api")
    response = client.login("your_username", "your_password")
    event = EventFabric::Event.new({
        "text" => "CPU",
        "percentage" => 80
    }, "your_channel")
    response = client.send_event(event);
 

Test
----

install http://rake.rubyforge.org/

::

    rake

License
-------

MIT

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
