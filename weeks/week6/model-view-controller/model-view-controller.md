## Design Patterns

Over time, the web (and therefore web development) has gotten increasingly complicated, requiring new and different ways of managing our information. Where once it was enough to organize HTML files into folders, now we have interactive web applications that have to manage complicated user interactions.

All web interactions occur over the HTTP protocol. The browser sends requests to web servers, and the server responds (generally with HTML). For dynamic and interactive websites, what happens in between is what really counts. Developers have conceived of different *design patterns* that help us organize this information in an intuitive way, both to the developers that write the code, and for users interacting with it.

When it comes to writing code to do these operations, a lot of work is required to do the most basic of functions, like setting up a web server to receive the incoming requests. A lot of that code ends up being boilerplate, and so reusable components and standards became an important part of the web space. Developers came together to talk and think about the best way to organize their code for the web, and the best way to write websites with a range of different use-cases. There have been many design patterns over the years, each with their own interesting use-case, pros, and cons.

More over, those design patterns have been interpreted and processed into *frameworks*, actual pieces of software that reflect the ideals spoused in the pattern. These frameworks and interpretations are themselves translations of a theoretical pattern into code, and are subject to just as many (if not more!) opinions as the actual design pattern themselves. In a way, the 'opinion' is the core currency of developers. As we increase in skill and experience, we should all feel empowered to share our professional opinions on the nature and structure of software development, both conceptually (as design patterns) and practically (as code).

## a Modern Design Pattern: MVC

One of the prevailing Design Patterns is called 'Model, View, Controller', or *MVC*. MVC has gained popularity in the web space due to the clear separation of responsibilities between its pieces. Let's take a look at what *exactly* those different pieces do.

### Models

A *Model* in an MVC framework is responsible for maintaining the state of our application. Typically, the model is an object with a persisted state managed through a database (usually through an 'adapter', Like `ActiveRecord`.). Objects can hold their own state in memory, but on a web server that memory gets re-appropriated very quickly by the server itself, and therefore, the state of that object doesn't persist. For some one-off logical tasks or calculations, this is entirely sufficient. A web app that let you estimate and plan savings into the future may not require any persistence from view to another.

If you were running a bank, however, you can imagine there are a great deal of things you'd like to keep track of. There's the user, their password, their username, payments that need to be made by the users, and - of course - their current bank balances. We might create a few models here to help us store the data required. A `User` model may want to keep track of it's own `username`, `password`, and `email`. A `BankAccount` model will certainly want to track its current `balance`.

Using database relations, we can associate these two Models, such that a `BankAccount` belongs to a `User`. This lets us keep our responsibilities even more separate. A `User` model doesn't even have any banking information directly attached to it. All of the banking functionality would be attached to the `BankAccount` model. Separating our responsibilities means that our system is more defined, and more malleable should it need to change in the future.

As we learned previously, the `Rails` web framework uses `ActiveRecord` to create, maintain, and query the information in the database. Rails uses Models to represent these databases.

```ruby
class User < ActiveRecord::Base
  has_one :bank_account
end

def BankAccount < ActiveRecord::Base
  belongs_to :user
end
```

In our Sinatra apps, the state of our application was handled by flat files (csv, txt) or a database. In some cases, we would have an object layer between our Sinatra app and the data. This object layer is provided for us in the Rails framework as `ActiveRecord`.

Ultimately, models are persisted data that we interact with through objects. None of the specifics of these Models ever make it to the user explicitly - by using a website, we are not (usually) able to easily guess how their system is architected. That's because, as a user of an MVC web app, we are only interacting with one thing directly: The view.

### Views

The *V* in MVC stands for *View*, the dynamic way we display information to the user.  Our views are largely written in dynamic supersets of HTML. These so-called 'templating' languages allow developers to write HTML as if it were code, mixing HTML with logic and data. That way, we can separate the look of site from the content that we save in our Models.

Our templated views are going to be rendered into raw HTML server-side. This process involves evaluating the lines of code in the template. Then, the rendered document is sent as HTML by the server to the browser. The browser only ever sees this end result.

For example, on a News sites 'list of articles' page, all the articles might look the same, and have the same CSS applied to them. However, their content is all different. That page was probably made using a templating language. The template was expecting data, organized into articles. It would be written to display those articles with the same general style. They would look a particular way, and when you clicked them, it would go to a specific place.

We have familiarized ourselves with the `Embedded Ruby (ERB)` templating language through writing Sinatra applications. `ERB` is a part of the core Ruby library, so we can utilize it in our Rails applications as well.

Templating languages allow us to save time and increase accuracy by leveraging the power of logic!

### Controller

The controller receives requests from the network. Based on those requests, it arranges the Models it needs, and feeds them to the views. It then returns the rendered HTML back to the browser as a response.

Website URLS are often patterned in such a way as to let the URL pass data to the controller in the form of a 'parameter'. Consider this url path:

`/articles`

This path suggests that we are looking for a resource - an 'article'. Moreover, because it is plural, we might guess that we are getting multiple articles.

The controller for this route would first get all of the Models of that resource - an `Article`. It would then feed those models into the `Views` that display all of the articles. The views get rendered into HTML, and the HTML is sent in a response to the browser.

The controller is our system's connection to the outside world. It intelligently displays what the request asks for.

### Router

The MVC design pattern can be applied to any software application. Web applications are a unique type of application, so they require a unique object to handle HTTP requests. The job of the *Router* is to map HTTP requests to Controller Actions.

In Sinatra, we handled a HTTP request such as `GET /articles`, with a block of code:

```ruby
get "/articles" do
  # retrieve data
  # render view
end
```

In the Rails framework, this functionality would be split across the `routes.rb` file, and the `articles_controller.rb`

```ruby
# routes.rb

Rails.application.routes.draw do
  get "/articles", to: "articles#index"
end
```

```ruby
# articles_controller.rb

class ArticlesController < ApplicationController
  def index
    # retrieve data
    # render view
  end
end
```

We will go into a more in-depth explanation of each of these components in later articles.

## MVC in the Wild

MVC is a pattern, one that can have many different interpretations in different applications. Here are a few popular MVC frameworks that use the MVC pattern.

### Ruby on Rails

Ruby on Rails ("Rails") is a popular MVC framework written in Ruby (no surprise there). It rose to popularity through its motto, "Convention over Configuration", making opinionated calls on how an application should be developed. It has a robust developers community and a strong eye towards writing testable code.

## Django

Django is a popular framework written in Python. While they follow many of the same design patterns as MVC frameworks, they use a slightly different terminology. Django comes with strong support for forms and a built-in admin interface. It is a great choice for teams using Python, and focuses on strong modularization of projects.

## Express

Express is an MVC framework written in JavaScript. It runs on the node server-side JavaScript engine, which allows us to run JavaScript (traditionally an in-browser language) on a web server. It's the newest of the MVC frameworks mentioned here, and it is useful for teams experienced with node apps.


## MVC on the front-end

The MVC pattern has appeared in new and interesting permutations with Front-end JavaScript applications.

JavaScript apps run entirely inside of the browser. These JS apps receive data through AJAX HTTP calls, and generate the HTML displayed on your browser.

Some JavaScript apps control small aspects of the entire web experience. They may only take parts of the MVC pattern in their execution. Some may only generate views, for instance, by reading data from an AJAX call. They may only borrow patterns from the `View`. If they keep track of the state of data in the JavaScript, maybe they also borrow patterns from `Models` - `MV` frameworks.

Others take over the entire screen, controlling every aspect of the web page. The traditional server is relegated to a data provider, and the JavaScript takes over all template rendering, routing, and interactivity. These are fully fledged MVC frameworks.

Front-end MVC frameworks are built to be interactive and speedy, providing a smooth user interface. They are a relatively new idea in web development, but support for them is growing.
