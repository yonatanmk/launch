In this article we'll review HTTP requests and how POST requests are handled via Rails.

### Learning Goals

* Review the HTTP verbs GET and POST
* Introduce additional HTTP verbs PUT, PATCH, and DELETE
* Manually send an HTTP POST request in Rails to save some content
* Learn about browser developer tools to view network requests

### A Review of HTTP

When we want to view a website, our browser will submit an **HTTP request** through the network to the server we want to talk to. When the server receives the HTTP request it will respond with an **HTTP response** that is sent back to our browser. The HTTP response will usually include some HTML that our browser knows how to display to the user.

![HTTP Request/Response Cycle](https://s3.amazonaws.com/horizon-production/images/http-request-response-cycle.png)

**GET** requests are used to retrieve information from a server while **POST** requests are used to modify or persist information. The most common way to submit an HTTP POST is by submitting an HTML form. The inputs on the form are sent as **parameters** to the server where the information may be persisted in a database. For example, when we fill out a product review form on Amazon and click "submit", our review will be persisted in Amazon's database somewhere.

### POST Requests

Let's explore what an HTTP POST request looks like in a Rails application. Run the following commands to clone and run Launcher News application if is not already setup:

```no-highlight
$ git clone https://github.com/LaunchAcademy/launcher_news.git
$ cd launcher_news
$ bundle
$ rake db:setup
```

Now start the Rails server:

```no-highlight
$ rails server --binding=0.0.0.0

=> Booting WEBrick
=> Rails 4.0.0 application starting in development on http://0.0.0.0:3000
...
```

We can view the site in a browser by visiting [http://localhost:3000/](http://localhost:3000) which shows a few sample articles. If we wanted to submit a new article we can fill out the form at [http://localhost:3000/articles/new](http://localhost:3000/articles/new).

When we submit the new article form, our browser will send an HTTP POST request to our web server which will persist the article in the database. To see how our application handles that request we can run the `rake routes` command in the terminal:

```no-highlight
$ rake routes
         Prefix Verb URI Pattern                Controller#Action
           root GET  /                          articles#index
search_articles GET  /articles/search(.:format) articles#search
       articles GET  /articles(.:format)        articles#index
                POST /articles(.:format)        articles#create
    new_article GET  /articles/new(.:format)    articles#new
        article GET  /articles/:id(.:format)    articles#show
```

Notice that we have the verb and the path for each route (e.g. `GET /` will access the `index` action of the `ArticlesController`). We can also see that each route corresponds to a particular controller action.

The action that we're interested in is `articles#create` since this is what will actually save a new article to the database. We can see that this route requires a `POST` request to be sent to the `/articles` path. Let's see if we can simulate this POST request with `telnet`.

Since our web application is running locally rather than on an external server we can specify `localhost` to indicate that we want to connect to our own machine. Our server is listening on port 3000 so to connect we'll have to use:

```no-highlight
$ telnet localhost 3000
```

To submit the actual HTTP request, we can copy and paste this snippet into the terminal:

```no-highlight
POST /articles HTTP/1.1
Host: localhost
Content-Length: 100

article%5Btitle%5D=hello&article%5Burl%5D=http%3A%2F%2Fexample.com&article%5Bdescription%5D=blarg%21
```

The first three lines form the HTTP request header. Here, we're specifying a `POST` request to the `/articles` path (which Rails will interpret as the `create` action on the `ArticlesController`). The last line lets the web server know how long the request body will be so it knows how much data to listen for: in this case it is expecting to receive 100 bytes.

After the request header we include the request body which contains the actual form data we want to submit. Although it looks like a bunch of gibberish, certain characters are not allowed to be sent in the HTTP request body so they are **encoded** instead (e.g. the `!` character is encoded as `%21`). If we were to decode the above string it would look something like:

```no-highlight
article[title]=hello&article[url]=http://example.com&article[description]=blarg!
```

When Rails is parsing the request it will extract these parameters into a hash structure:

```no-highlight
{"article"=>{"title"=>"hello", "url"=>"http://example.com", "description"=>"blarg!"}}
```

This becomes part of the **params** hash that we can access in the controller to read in user input.

If we're successful, we should get an HTTP response that looks something like:

```no-highlight
HTTP/1.1 302 Found
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Location: http://localhost/articles/10
Content-Type: text/html; charset=utf-8
Cache-Control: no-cache
X-Request-Id: e2bff9a0-d6d7-4fff-aa06-bf4b793cf5b6
X-Runtime: 0.009782
Server: WEBrick/1.3.1 (Ruby/2.0.0/2013-06-27)
Date: Tue, 17 Dec 2013 19:15:19 GMT
Content-Length: 94
Connection: close

<html><body>You are being <a href="http://localhost/articles/10">redirected</a>.</body></html>
```

The 302 HTTP response code is redirecting us to another page to view the article that we just created. If we visit [http://localhost:3000](http://localhost:3000) we should see our new article has been added to the list.

### PUT, PATCH, DELETE

While GET and POST are the most common HTTP requests you'll encounter, Rails also makes use of a handful of other HTTP verbs.

A **PUT** request is similar to a POST except that it is typically used to modify an existing resource rather than creating a new one. **PATCH** is similar to PUT except that it is used for partially modifying a resource. A **DELETE** request is used when you want to remove a particular resource. The full list of verbs can be found [here](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods).

For the most part, we don't need to worry too much about whether to send a POST vs. PUT or a PUT vs. PATCH as Rails will handle these details for us. The meaning of these verbs is primarily for semantic purposes and are used by Rails to simplify URLs. It's important to realize that every route is made up of both the verb _and_ the path: there is a very big difference between `GET /articles` and `POST /articles` (the former retrieves all articles and the latter will create a new article).

### HTTP is Stateless

One very important aspect of HTTP is that it is **stateless**. This means that after we are done communicating with a server (i.e. we sent a request and received a response) the server can close the connection and forget all about us. The next time we connect to the server it won't necessarily retain any information about our past requests.

This simplifies the development of our application a bit. We don't have to worry about storing information about who connected and what they did in case they come back. If we do receive another request from the same client we can treat them as if they were total strangers.

The downside to this is that sometimes we do want to remember when someone has visited our site before. For example, if someone logs in on one request, we probably want to know that they are authenticated the next request they send to the site. For this we can use something called **HTTP cookies** to send bits of information back and forth with each request. This information could include the identify of the client so the server knows if they're logged in or not.

### Resources

* [List of HTTP Response Codes](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes)
* [List of HTTP Verbs](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods)
* [HTTP Tutorial](http://net.tutsplus.com/tutorials/tools-and-tips/http-the-protocol-every-web-developer-must-know-part-1/)
