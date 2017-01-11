## Introduction

Web browsers render pages consisting of HTML, CSS, and JavaScript, but how does
the browser retrieve this content in the first place? In this article, we will
set up a basic **web server** to host our pages.

### Learning Goals

* Understand the request-response nature of HTTP.
* Review the different parts of an HTTP response.
* Review different HTTP response codes.
* Create a simple web application with **Sinatra**.
* Manually send an HTTP GET request with the cURL command.

### A Basic Web Page

Let's start with a simple HTML page representing a TODO list. In a new directory
called `todo_list` save the following HTML in a file called `home.html`:

```HTML
<!DOCTYPE html>
<html>
  <head>
    <title>Basic HTML Page</title>
  </head>

  <body>
    <h1>TODO list</h1>

    <ul>
      <li>pay bills</li>
      <li>buy milk</li>
      <li>learn Ruby</li>
    </ul>
  </body>
</html>
```

Here we have a single `<head>` tag and a few items in an unordered list.
If we want to see how the HTML will be rendered, we can load this file directly
in the browser. Pressing `Ctrl` + `O`, or `Cmd` + `O` in Chrome or Firefox will
open a dialog box where you can select the `home.html` file you just created.
Alternatively, you can launch the browser with the specific file from the
command line:

```no-highlight
$ open home.html
```

![Our un-styled TODO list.][unstyled-todo]

This is a pretty bland looking page so let's add some CSS to change the default
styles. If we wanted this to be a ["Matrix"-style][matrix-style] TODO list we
can add the following CSS in a file called `home.css`:

```CSS
body {
  /* Use a "Matrix"-style color scheme. */
  background-color: black;
  color: #00ff00;

  font-family: monospace;
  font-size: 1.5em;
}

ul {
  /* Wrap the list in a green box. */
  width: 300px;
  border: 1px solid #00ff00;
}

li {
  /* Add a bit more spacing between list items. */
  padding: 5px;
}
```

Then in the HTML we can add a link back to this stylesheet in the `<head>`
section:

```HTML
<head>
  <title>Basic HTML Page</title>
  <link rel="stylesheet" href="home.css">
</head>
```

After refreshing the page in the browser we should get a flashback to 1999.

![TODO list, "Matrix"-style.][styled-todo]

### Hosting Pages

If we look at the URL in the browser we might notice that it doesn't look like a
typical web address. The browser is loading the files directly from our
filesystem with a URL like:

```no-highlight
file:///home/asheehan/work/todo_list/home.html
```

This is fine for testing out our web pages, but doesn't really work when we want
to share our site with the world. What we can do instead is use a **web server**
to host our files somewhere publicly accessible so others can view them.

When we visit [http://www.google.com][google], we're communicating
with a **web server** that will send back the HTML, CSS, and JavaScript for the
Google homepage. A web server is a software application that listens for requests
for web pages and will respond with the appropriate content. Every website has
one or more web servers listening for requests, running various kinds of software
that will determine how each request will be handled.

*Note: A web server can also refer to a physical machine running a web
application, usually sitting in a data center somewhere with
[lots of blinky lights][physical-server]. For this article when we talk about a
web server, we're referring to the software, not the hardware.*

Let's create a very simple web app that will serve our HTML and CSS using the
**Sinatra** framework. A framework is packaged code that lays out the structure
for what kind of programs can be built and how to build them. Frameworks read
and execute your code with a set of assumptions. Frameworks also help us keep
code organized and efficient. Instead of performing the same type of task again
and again, we can use a framework that has those functions together in one nice
package. We will be using Sinatra because it is a lightweight framework written
in Ruby. Install Sinatra with the following command:

```no-highlight
$ gem install sinatra
```

After that's installed, let's move our HTML and CSS to a separate folder called
`public` that will store all of our static files:

```no-highlight
$ mkdir public
$ mv home.html home.css public
```

Now we can create our Sinatra app in a file called `server.rb`, which should be
saved in our project's root directory:

```ruby
require "sinatra"

set :bind, '0.0.0.0'  # bind to all interfaces
set :public_folder, File.join(File.dirname(__FILE__), "public")
```

In this file, we are including the Sinatra framework (`require "sinatra"`) and
then specifying that our static files are in the `public` folder we just created.
We could actually omit this line since Sinatra will look for files in the
`public` and serve them, but here we're being explicit. Sinatra handles setting
up a web server for us so there is not much else we need to do. We are also
binding the Sinatra webserver to all network interfaces, so we can run this
code within a Virtual Machine, if necessary.

To test out our web app we can start up the server with the following command:

```no-highlight
$ ruby server.rb

[2015-02-04 15:57:50] INFO  WEBrick 1.3.1
[2015-02-04 15:57:50] INFO  ruby 2.2.0 (2014-12-25) [x86_64-linux]
== Sinatra/1.4.5 has taken the stage on 4567 for development with backup from WEBrick
[2015-02-04 15:57:50] INFO  WEBrick::HTTPServer#start: pid=13641 port=4567
```

To view our TODO list we can now visit [http://localhost:4567/home.html][homepage]
which should return the same HTML and CSS we had before.

### HTTP

So what happens when we visit [http://localhost:4567/home.html][homepage]? If we
look at the output from `ruby server.rb` we'll see some lines that look like:

```no-highlight
127.0.0.1 - - [04/Feb/2015:15:57:58 -0500] "GET /home.html HTTP/1.1" 200 267 0.0046
localhost - - [04/Feb/2015:15:57:58 EST] "GET /home.html HTTP/1.1" 200 267
- -> /home.html
127.0.0.1 - - [04/Feb/2015:15:57:58 -0500] "GET /home.css HTTP/1.1" 200 310 0.0005
localhost - - [04/Feb/2015:15:57:58 EST] "GET /home.css HTTP/1.1" 200 310
http://localhost:4567/home.html -> /home.css
```

These are logs of HTTP requests that were received and handled by the web server.
**HTTP** is the protocol that web servers and their clients use to communicate.
In this case, the client is typically a web browser. When we want to view a page,
we enter the URL into our browser which then sends an **HTTP request** to the
web server at the given address. The server receives the request and then returns
with an **HTTP response** containing the content for that page (usually HTML,
CSS, or Javascript). When the browser receives the HTML and CSS, it draws it in
the window.

### Using cURL

![cURL example][curl-example]

**HTTP is a plain-text protocol**. It is both human and machine
readable. An HTTP request is just a stream of characters sent over the network
to a listening web server. Although our browser handles sending and receiving
HTTP requests and responses in the background, we can also communicate via HTTP
using a command line tool called *cURL*. If we call the `curl` command with a
single argument, a URL, it will make a HTTP GET **request** to the web server.
Then, the **response** from the web server will be printed to your screen.

For example, to get the `home.html` file from our Sinatra app, **open a new
terminal window**, and type the following command.

```no-highlight
curl --request GET http://localhost:4567/home.html
```

This command will only show you the **body** of the response, and none of the
associated HTTP metadata.

```no-highlight
<!DOCTYPE html>
<html>
  <head>
    <title>Basic HTML Page</title>
    <link rel="stylesheet" href="home.css">
  </head>

  <body>
    <h1>TODO list</h1>

    <ul>
      <li>pay bills</li>
      <li>buy milk</li>
      <li>learn Ruby</li>
    </ul>
  </body>
</html>
```

If you would like to see the response headers in addition to the response body,
use the `--verbose` option.

```no-highlight
$ curl --verbose --request GET http://localhost:4567/home.html
*   Trying ::1...
* Connected to localhost (::1) port 4567 (#0)
> GET /home.html HTTP/1.1
> Host: localhost:4567
> User-Agent: curl/7.43.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: text/html;charset=utf-8
< Last-Modified: Fri, 29 Jul 2016 16:17:21 GMT
< Content-Length: 269
< X-Xss-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< X-Frame-Options: SAMEORIGIN
< Server: WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
< Date: Fri, 29 Jul 2016 16:54:36 GMT
< Connection: Keep-Alive
<
<!DOCTYPE html>
<html>
  <head>
    <title>Basic HTML Page</title>
    <link rel="stylesheet" href="./home.css">
  </head>

  <body>
    <h1>TODO list</h1>

    <ul>
      <li>pay bills</li>
      <li>buy milk</li>
      <li>learn Ruby</li>
    </ul>
  </body>
</html>
* Connection #0 to host localhost left intact
```

The **response** is divided up into two sections: the response **headers** and
the response **body**. The first line of the headers indicates the **status** of
the response:

```no-highlight
HTTP/1.1 200 OK
```

In this case we received a *200 OK* response indicating that everything went
smoothly. Following the status line are a list of HTTP headers with additional
details about the response: the type of content being sent back, the size of the
response, when this file was last modified, and other information.

After the last header there is a blank line and then comes the response **body**.
This is where the HTML we created earlier gets included. The contents of the
HTTP response body should be identical to the contents of the `home.html` file
in our `public` directory.

Notice that we didn't receive any CSS back. This is because we are keeping our
CSS in an *external* stylesheet that is linked to from our HTML page
(`<link rel="stylesheet" href="home.css">` in the `<head>` section). To retrieve
the stylesheet, we must issue a second HTTP GET request targeting the
`/home.css` path instead of `/home.html`.

When a browser receives this response, it can then apply these styles to the
HTML it received earlier. **It is typical for a browser to send many HTTP
requests to load a single page**. After getting back the initial response, a
browser will search the HTML for any other resources that it needs to retrieve.
External stylesheets, JavaScript files, images, and other assets each get their
own HTTP requests.

Most modern browsers include a way to monitor the HTTP requests and responses
going back and forth. In Chrome, clicking on *View > Developer > Developer Tools*
and opening the *Network* tab will show all communication between the browser
and the server. For Firefox the same information can be found in *Tools >
Web Developer > Network*. Once the tool is running, visiting a new page will
populate it with all of the requests being made. For example, visiting
[http://www.google.com][google] resulted in over 20 requests being sent to load
the home page with all of its assets!

### HTTP Response Codes

So far we've only seen vanilla HTTP responses: a status code of 200 indicates
that everything went OK. There are other response codes for when things don't go
so smoothly.

Let's try requesting a page that we know doesn't exist. Use `curl` to make the
following request:

```no-highlight
$ curl --verbose --request GET http://localhost:4567/does-not-exist.html
*   Trying ::1...
* Connected to localhost (::1) port 4567 (#0)
> GET /does-not-exist.html HTTP/1.1
> Host: localhost:4567
> User-Agent: curl/7.43.0
> Accept: */*
>
< HTTP/1.1 404 Not Found
< Content-Type: text/html;charset=utf-8
< X-Cascade: pass
< Content-Length: 478
...
```

Notice the first line of the response: `HTTP/1.1 404 Not Found`. A 404 response
code is a way for the server to tell the client that what they requested does
not exist. The response also includes some HTML with an error message to display
to the user, although, not all responses need to include a body.

Another common response code is a redirect sending the client to a different web
page. Let's try sending a request to [http://google.com][google-no-www].

```no-highlight
$ curl --verbose --request GET http://google.com
* Rebuilt URL to: http://google.com/
*   Trying 172.217.4.46...
* Connected to google.com (172.217.4.46) port 80 (#0)
> GET / HTTP/1.1
> Host: google.com
> User-Agent: curl/7.43.0
> Accept: */*
>
< HTTP/1.1 301 Moved Permanently
< Location: http://www.google.com/
< Content-Type: text/html; charset=UTF-8
< Date: Fri, 29 Jul 2016 17:07:10 GMT
< Expires: Sun, 28 Aug 2016 17:07:10 GMT
< Cache-Control: public, max-age=2592000
< Server: gws
< Content-Length: 219
< X-XSS-Protection: 1; mode=block
< X-Frame-Options: SAMEORIGIN
<
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
* Connection #0 to host google.com left intact
```

The first line of the response indicates a redirect: `HTTP/1.1 301 Moved
Permanently`. This is letting the client know that the resource they are
requesting can be found somewhere else. The next response header actually
includes the updated location so the browser can send another request. In this
case we're being redirected from [http://google.com][google-no-www] to
[http://www.google.com][google]. This is a common way of allowing users to type
in either address and still end up at the same place.

### In Summary

So far we've covered sending HTTP GET requests and a handful of the different
[HTTP responses][status-codes] we might receive. This request-response protocol
is fundamental to how HTTP works and how data is typically transferred over the
web.

An HTTP request consists of a **method** and a **path** that specifies what
action we want to take along with any additional headers (e.g.
`Host: www.google.com`). We've only looked at the **HTTP GET** method which is
used for *retrieving* resources from a web server but there are a handful of
other methods in use as well (e.g. **HTTP POST** for submitting data to a server).

An HTTP response contains a header and (usually) a body. The header includes a
**response code** that indicates the status of the request (e.g. **200 OK** if
everything went well, **404 Not Found** if the resource doesn't exist, etc.).
The body contains the content that was requested which could be HTML, CSS,
JavaScript, or any other type of data.

A Framework is packaged code that lays out the structure for what kind of
programs can be built and how to build them. Frameworks read and execute your
code with a set of assumptions. For more information on the Sinatra framework
you can find the documentation, [here][sinatra-docs].

[sinatra-docs]: http://www.sinatrarb.com/intro.html
[homepage]: http://localhost:4567/home.html
[matrix-style]: https://www.google.com/search?tbm=isch&q=the+matrix+style
[google]: http://www.google.com
[physical-server]: https://s3.amazonaws.com/horizon-production/images/data-center-servers-t001.jpg
[http]: http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol
[status-codes]: http://en.wikipedia.org/wiki/List_of_HTTP_status_codes
[google-no-www]: http://google.com
[unstyled-todo]: https://s3.amazonaws.com/horizon-production/images/unstyled_todo.png
[styled-todo]: https://s3.amazonaws.com/horizon-production/images/styled_todo.png
[curl-example]: https://s3.amazonaws.com/horizon-production/images/curl.png
