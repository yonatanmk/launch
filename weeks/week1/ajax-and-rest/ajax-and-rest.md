## Interacting with a RESTful Interface Using AJAX

In this article, we will cover **Representational State Transfer**, or **REST**, in a beginner-friendly way. If you care to bore yourself with the technical details of this specification, please check out the article on [Wikipedia](https://en.wikipedia.org/wiki/Representational_state_transfer), or [Roy Fielding's Dissertation](https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm) on the subject.

### Mapping Verbs to Actions

One of the key ideas behind REST is to define a mapping between HTTP Requests and the actions performed on the server-side.

The HTTP Verbs we are concerned with as Web Developers are as follows:

* `GET`
* `POST`
* `PUT`/`PATCH`
* `DELETE`

We would like to map these HTTP Verbs to CRUD actions on the server-side. So, when a client makes a HTTP Request (which consists of a HTTP Verb and a Path), the server will perform a **C**reate, **R**ead, **U**pdate, or **D**elete action on a resource.

REST defines this mapping as so:

| HTTP Verb     | Server Action |
| ------------- | ------------- |
| `GET`         | Read          |
| `POST`        | Create        |
| `PUT`/`PATCH` | Update        |
| `DELETE`      | Delete        |

A more complete description of a RESTful web service can be found, [here](http://www.restapitutorial.com/lessons/httpmethods.html)

### Implementing REST in Sinatra

We have expanded on our Fortune Telling app and built a RESTful JSON interface for fortunes. Clone down the repo and fire up the server to follow along.

```no-highlight
et get ajax-and-rest
cd ajax-and-rest
cd fortune-teller
ruby server.rb
```

| HTTP Verb | Path                        | Server Action                            |
| --------- | --------------------------- | ---------------------------------------- |
| `GET`     | `/api/v1/fortunes.json`     | Read all the fortunes                    |
| `GET`     | `/api/v1/fortunes/:id.json` | Read the fortune with the specified id   |
| `POST`    | `/api/v1/fortunes.json`     | Create a new fortune                     |
| `PUT`     | `/api/v1/fortunes/:id.json` | Update the fortune with the specified id |
| `DELETE`  | `/api/v1/fortunes/:id.json` | Delete the fortune with the specified id |

Try visiting some of the `.json` paths that are defined.

![JSON Fortunes](http://i.imgur.com/TR8i4ke.png)

### AJAXing it up

With our server interface defined, we can interact with that interface by writing some client-side JavaScript. Let's start by adding a new fortune. Visit the [index page](http://localhost:4567/fortunes) of the app and try out the following code in the Chrome Developer Console.

```javascript
// crud.js
// create a fortune
// http://api.jquery.com/jquery.ajax/
//
var fortune = { content: "Walk through life like a badass." };
var request = $.ajax({
  method: "POST",
  url: "/api/v1/fortunes.json",
  data: fortune
});

request.done(function() {
  alert("New fortune accepted");
});
```

In order to check that this was successful, we need to refresh the page.

Let's build a feature that allows the user to enter a new fortune via a form, creates a new record by posting that data to the server via AJAX, and, upon a successful response, updates the page with that new record.


### HTML + HTTP, first

Before we dive into implementing this feature using AJAX, let's get a form working without it. Every modern browser supports JavaScript, but, it is a worthwhile exercise to get form submission working without it. There are a number of things we will reuse between a plain old HTML form submission (the form, the code for saving the data). Plus, it is just good _form_ to have this to fall back on if JS is disabled on the client browser.

```html
<!-- index.erb -->

<form action="/fortunes" method="post" id="fortune-form">
  <fieldset>
    <legend>Add a Fortune</legend>
    <input id="fortune_content" name="content" type="text"></input>
    <input type="submit"></input>
  </fieldset>
</form>
```

```ruby
# server.rb

post "/fortunes" do
  unless params[:content].nil? || params[:content].empty?
    Fortune.create(params[:content])
  end
  redirect to("/fortunes")
end
```

### AJAX POST

Now that the feature for adding a new fortune is wired up, let's make it happen without a full page reload.

There are a few steps to get this to work.

1. Prevent the form from submitting normally.
2. Post the form data via AJAX.
3. Upon success, update the page.

```javascript
// fortune.js
// create a new fortune and update the page
//
$("form").on("submit", function(event) {
  event.preventDefault();
  var newFortuneContent = $('#fortune-content').val()

  var request = $.ajax({
    method: "POST",
    data: { content: newFortuneContent },
    url: "/api/v1/fortunes.json"
  });

  request.done(function() {
    $("ul.fortunes").append("<li>" + newFortuneContent + "</li>");
    $('#fortune-content').val("");
  });
});
```

We need code on the server-side to handle the `POST`ing of a new fortune via JavaScript.

```ruby
# server.rb

post "/api/v1/fortunes.json" do
  unless params[:content].nil? || params[:content].empty?
    # 201 Created, Location: /fortunes/:id
    fortune = Fortune.create(params[:content])

    status 201
    headers "Location" => "/fortunes/#{fortune.id}"
  else
    status 400
  end
end
```

### Front-end Programming

There is a general set of steps for implementing AJAX functionality in a web application:

1. User interacts with the page (via clicking on some element in the [Document Object Model](https://en.wikipedia.org/wiki/Document_Object_Model), or **DOM**).
2. This triggers a JavaScript **event handler** (e.g.- `function(event) {}`), which makes a HTTP request to the server.
3. When the server responds to the HTTP request, a JavaScript **callback function** is executed (e.g.- `request.done(function() {})`), which updates the DOM.

## Other HTTP methods

Here are code examples which can be run from your browser's developer console. Implementing this functionality in the Fortune Teller web application is left as an exercise for the reader.

### AJAX PUT

```javascript
// crud.js
// update a fortune
// http://api.jquery.com/jquery.ajax/
//
requestData = {
  method: "PUT",
  url: "/api/v1/fortunes/8.json",
  data: { content: "You are confused; but clarity will come soon." }
};

var request = $.ajax(requestData);
request.done(function(msg) {
  alert("Fixed that terrible fortune: " + msg);
});
```

### AJAX DELETE

```javascript
// crud.js
// delete a fortune
// http://api.jquery.com/jquery.ajax/
//
requestData = {
  method: "DELETE",
  url: "/api/v1/fortunes/8.json"
};

var request = $.ajax(requestData);
request.done(function(msg) {
  alert("Deleted that terrible fortune: " + msg);
});
```

## Wrap Up

In this article, we covered how to create a web form that submits **asynchronously**. The benefits of which are that we do not need a full page reload, which creates a more elegant user experience.
