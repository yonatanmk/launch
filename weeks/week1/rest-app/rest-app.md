### Introduction

In this exercise, we will interact with a Sinatra Web Application in order to
learn how to create, read, update, and delete (**CRUD**) data with HTTP.

### Learning Goals

* Perform HTTP requests using the `curl` command line utility.
* Perform HTTP GET requests using Ruby's `Net::HTTP` library.

### Getting Started

```no-highlight
$ et get rest-app
$ cd rest-app
$ bundle
$ ruby server.rb
```

In your browser, issue a `GET` request for <http://localhost:4567/messages>.

Or, in layman's terms, visit <http://localhost:4567/messages>.

Here, you should see a list of messages.

```no-highlight
Not all who wander are lost
Do or do not. There is no pry.
highway to the DANGER ZONE
lalalala
minions love banana
I LOVE CATS SO MUCH
the answer is 42
mytest1
omg no php
ヽ༼ຈل͜ຈ༽ﾉ im bad ヽ༼ຈل͜ຈ༽ﾉ
mytest1
hello
(ノ^_^)ノ┻━┻ ┬─┬ ノ( ^_^ノ)
I am the very model of a modern, major Rubyist.
you miss every shot you dont take :)
...
```

In terms of HTTP, we issued a `GET` **request** for the `/messages` resource. The
server then **responded** with a list of messages. Essentially, we performed a
**read** operation.

### Reading a Single Message with GET

The server we have running is also capable of responding with a single message.
All we have to do is specify the line number of the message we would like to
read.

Issue a `GET` request from your browser for the `/messages/7` resource.

```no-highlight
the answer is 42
```

### Reading data from a server from the command line

The `curl` command line app lets us make HTTP requests from the command line. If
we want to read the index page of messages, we can tell `curl` to issue a `GET`
request.

With your server running in one terminal window, open another terminal window
and try the following command:

```no-highlight
$ curl --request GET http://localhost:4567/messages
<br/>Not all who wander are lost
<br/>Do or do not.  There is no pry.
...
```

**Note**: The line-break `<br/>` tags are present so that each message shows up
on a separate line in our web browser.

Likewise, we can issue a `GET` request for a single message.

```no-highlight
$ curl --request GET http://localhost:4567/messages/7
the answer is 42
```

### Creating a new message with POST

Now, it's time for you to create a new message on the server using `curl`. The
command will need to match the following format:

```no-highlight
                                                   "data" flag             value
                                                     ┌──┴──┐         ┌───────┴────────┐
$ curl --request POST http://localhost:4567/messages --data "message=your message, here"
                                                             └──┬──┘
                                                               key
```

The response from the server will inform you if you were successful or not.
Point your browser at <http://localhost:4567/messages> to see your new message.

### Updating a message with PATCH

Let's change the first message. We can do this by performing a `PATCH` request
on the URL for the first message.

```no-highlight
$ curl --request PATCH http://localhost:4567/messages/1 --data "message=I am number one"
```

When we issue a `PATCH` request, we aren't creating something new, we're modifying
an existing resource.

### Deleting a message

To delete a resource, we issue a `DELETE` request on the URL of the message we
would like to delete.

```no-highlight
$ curl --request DELETE http://localhost:4567/messages/25
```

### Ruby's Net::HTTP library

Ruby has a built-in library for communicating with web servers. Let's try reading
messages from our web server, programmatically.

```no-highlight
# messages.rb

require "net/http"

messages_url = "http://localhost:4567/messages"
uri = URI.parse(messages_url)           # convert the URL string to a URI object
response = Net::HTTP.get_response(uri)  # issue a HTTP GET request
puts response.body                      # print the body of the response
```

This code issues a GET request to our locally running Sinatra server, and
retrieves the `/messages` resource.


### Communicating with Web Servers

The Internet consists of millions of web servers, each one waiting for you to
make a request for the resources they provide. They host information such as the
current weather conditions, stock market prices, and even [images from other
worlds](https://api.nasa.gov/api.html#apod). The best part is, **all of these
servers speak HTTP**.

We can write Ruby code to interact with these web servers.

```no-highlight
# weather.rb

require "net/http"
require "active_support/core_ext/hash"
require "pp"

weather_url = "http://forecast.weather.gov/MapClick.php?lat=42.35&lon=-71.06&FcstType=dwml"
uri = URI.parse(weather_url)            # convert the URL string to a URI object
response = Net::HTTP.get_response(uri)  # issue a HTTP GET request
body = Hash.from_xml(response.body)     # convert XML to a more familiar data type

pp body  # "pretty-print" the hash
```

Executing this code will provide us with the current weather data for Boston, MA.


### Wrap up

In this lesson, we practiced creating, reading, updating, and deleting resources
using the HTTP protocol.


### Resources

* [Manual - curl usage explained](https://curl.haxx.se/docs/manual.html)
* [Net::HTTP Cheat Sheet](http://www.rubyinside.com/nethttp-cheat-sheet-2940.html)
* [PP - ruby-doc.org](https://ruby-doc.org/stdlib/libdoc/pp/rdoc/PP.html)
