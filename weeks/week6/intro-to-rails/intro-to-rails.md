In this article we'll discuss **Ruby on Rails**, a popular Web Development Framework, written in the Ruby programming language.

### Learning Goals

* Learn how to generate a new Rails application
* Explore the file structure of a Rails application
* Add a new resource to an application

### What is Rails?

Ruby on Rails is a web framework that minimizes the amount of code needed to get up and running. By heavily embracing **convention over configuration**, many of the common patterns that appear across web applications are used implicitly without requiring the developer to configure them. This means we can focus our time and energy on what makes our applications different from others knowing that Rails is making sensible defaults for everything else.

When we talk about Rails, we're often referring to one of two things: the **Rails framework** or a **Rails application**. The _Rails framework_ consists of many separate components packaged together as a RubyGem. We use this framework to build a _Rails application_ that lets us define behavior that is specific to our app. We _use_ the Rails framework to _build_ a Rails application.

### Starting a New Rails Application

Because Rails follows convention over configuration, it expects certain files to exist in certain locations. Rather than manually creating these files by hand, we can use a template to start a new Rails application. This template is made available via the **rails new** command.

First we need to install the Rails framework:

```no-highlight
$ gem install rails
Successfully installed rails-5.0.0.1
1 gem installed
```

Once the framework is installed we should have access to the `rails` command:

```no-highlight
$ rails -v
Rails 5.0.0.1
```

If we run `rails new` it will generate the files necessary to start a new Rails application. Let's create an application to list news articles:

```no-highlight
$ rails new launcher_news --database=postgresql --skip-turbolinks --skip-test-unit
      create
      create  README.rdoc
      create  ....
         run  bundle install
Fetching gem metadata from https://rubygems.org/............
Resolving dependencies...
...
Your bundle is complete!
```

This command will create a new Rails application in the `launcher_news` directory using a predefined template. Once the files are added, all dependencies are installed using [Bundler](http://bundler.io/). We also used several options to specify what we wanted to include (or exclude) in our application:

* **--database=postgresql** will configure the application to connect to a PostgreSQL database rather than SQLite (the default). The connection information is stored in the `config/database.yml` file.
* **--skip-turbolinks** will exclude [turbolinks](https://github.com/rails/turbolinks) from the application. Turbolinks can be used to improve the page load times but can also result in hard-to-debug problems with JavaScript so we'll exclude them for now.
* **--skip-test-unit** will avoid creating a `test` directory. Rails uses the [Test::Unit](https://github.com/test-unit/test-unit) testing framework by default but we'll end up replacing it with RSpec.

Once the application has been created, the first step should be to configure version control:

```no-highlight
$ cd launcher_news
$ git init
$ git add -A
$ git commit -m 'Initial commit'
```

Now any changes we make to customize our app will be distinct from those auto-generated by the `rails new` command.

### Exploring a Rails Application

When we generate a new Rails application we end up with ~40 files in our project directory:

```no-highlight
.
├── Gemfile
├── README.md
├── Rakefile
├── app
│   ├── assets
│   │   ├── config
│   │   │   └── manifest.js
│   │   ├── images
│   │   ├── javascripts
│   │   │   ├── application.js
│   │   │   ├── cable.js
│   │   │   └── channels
│   │   └── stylesheets
│   │       └── application.css
│   ├── channels
│   │   └── application_cable
│   │       ├── channel.rb
│   │       └── connection.rb
│   ├── controllers
│   │   ├── application_controller.rb
│   │   └── concerns
│   ├── helpers
│   │   └── application_helper.rb
│   ├── jobs
│   │   └── application_job.rb
│   ├── mailers
│   │   └── application_mailer.rb
│   ├── models
│   │   ├── application_record.rb
│   │   └── concerns
│   └── views
│       └── layouts
│           ├── application.html.erb
│           ├── mailer.html.erb
│           └── mailer.text.erb
├── bin
│   ├── bundle
│   ├── rails
│   ├── rake
│   ├── setup
│   └── update
├── config
│   ├── application.rb
│   ├── boot.rb
│   ├── cable.yml
│   ├── database.yml
│   ├── environment.rb
│   ├── environments
│   │   ├── development.rb
│   │   ├── production.rb
│   │   └── test.rb
│   ├── initializers
│   │   ├── application_controller_renderer.rb
│   │   ├── assets.rb
│   │   ├── backtrace_silencers.rb
│   │   ├── cookies_serializer.rb
│   │   ├── filter_parameter_logging.rb
│   │   ├── inflections.rb
│   │   ├── mime_types.rb
│   │   ├── new_framework_defaults.rb
│   │   ├── session_store.rb
│   │   └── wrap_parameters.rb
│   ├── locales
│   │   └── en.yml
│   ├── puma.rb
│   ├── routes.rb
│   └── secrets.yml
├── config.ru
├── db
│   └── seeds.rb
├── lib
│   ├── assets
│   └── tasks
├── log
├── public
│   ├── 404.html
│   ├── 422.html
│   ├── 500.html
│   ├── apple-touch-icon-precomposed.png
│   ├── apple-touch-icon.png
│   ├── favicon.ico
│   └── robots.txt
├── test
│   ├── controllers
│   ├── fixtures
│   │   └── files
│   ├── helpers
│   ├── integration
│   ├── mailers
│   ├── models
│   └── test_helper.rb
├── tmp
│   └── cache
│       └── assets
└── vendor
    └── assets
        ├── javascripts
        └── stylesheets```

Let's briefly touch upon what some of these files and directories are used for:

* The **app** directory is where we'll do most of our work. This directory contains all of the models, views, controllers, and assets that are specific to our application.
* **app/assets** contains any CSS, JavaScript, images, fonts, etc. used in our application. It also supports languages such as [Sass](http://sass-lang.com/) and [CoffeeScript](http://coffeescript.org/) that ultimately compile to CSS and JavaScript. This directory is managed via the **asset pipeline** which will automatically compile and minimize asset files when deployed to minimize bandwidth usage.
* **app/models** contains any models we define. Models are typically ActiveRecord classes but we can also include plain Ruby classes are responsible for handling any business logic.
* **app/controllers** contains any controllers we define. Controllers are responsible for processing requests, user authentication and access control, and generating responses.
* **app/views** contains any views we define. Rails uses ERB by default but views can be written in other languages such as [Haml](http://haml.info/) or [Jbuilder](https://github.com/rails/jbuilder).
* **app/helpers** contains modules that define helper methods. Helper methods are available in our controllers and views and can be used to simplify common operations.
* **app/mailers** contains classes for generating e-mails.
* **bin** contains scripts used to run tasks. We should never need to modify the files in this directory. If we ever want to add custom tasks we can define them in the **lib/tasks** directory.
* **config** contains configuration settings used by the application.
* **config/application.rb** defines settings used across _all environments_.
* **config/environments** contains configuration settings _per environment_. For example, we may certain settings for production where we want to optimize for speed and security, whereas in development we care more about settings to speed up debugging.
* **config/initializers** contains files that need to be run when the application is starting up. If any of these files are changed, the application needs to be restarted before they will take effect.
* **config/database.yml** defines the settings used to connect to the database.
* **config/secrets.yml** defines the secret key used to verify the integrity of signed cookies.
* **config/routes.rb** defines the URL endpoints available for our application. Requests first pass through the router which then forwards them on to the appropriate controller.
* The **db** directory contains files related to the database.
* **db/migrate** will contain any migrations for the application. This directory is created once the first migration as added.
* **db/schema.rb** will contain the overall schema found in the configured database. This file is auto-generated after running the `rake db:migrate` command.
* **db/seeds.rb** is a Ruby script that can be used to insert prerequisite information into the database. Seed data should only be used if it is necessary for the application to run (e.g. inserting a predefined list of U.S. states for a user to choose from). Information that is generated by users should not be included as a seed file but rather inserted via database backup and restore. This file will be run on the `rake db:seed` command.
* The **lib** directory contains additional Ruby classes that are useful but not specific to this application.
* **lib/tasks** contains any custom **rake** tasks for the application. Any files must end with `.rake` to be recognized by the `rake` command.
* The **log** directory stores the output from the server log in any of the environments.
* The **public** directory stores any static files that can be served directly by the web server. Note that this usually excludes CSS and JavaScript files since it is preferable to use the asset pipeline in **app/assets** to handle those.
* The **vendor** directory contains any third-party code that is not packaged as part of a RubyGem.
* **config.ru** contains instructions for how to start the server. This file should not be modified for most applications.
* The **Gemfile** specifies any libraries and (optionally) their versions that are required to run the application. Once the `bundle` command has been run, the **Gemfile.lock** file includes all gems and versions installed so that all developers are working with the same set of libraries.
* **.gitignore** excludes certain files that are non-essential or contain sensitive information from the version control system.
* **Rakefile** initializes the **rake** command. This file should not be modified for most applications. Any custom rake tasks should be added to the **lib/tasks** directory.
* The **README.rdoc** file should be updated to describe the application and any additional information useful when working on it. This file is displayed by default once the repository is pushed to GitHub. The extension could be changed to `README.md` if we prefer to use Markdown formatting over RDoc.

Most of the time we'll be working within the **app** directory to change our models, views, and controllers, the **db/migrate** directory to add new migrations, and the **conf/routes.rb** file for updating the available endpoints for our application.

### Starting our Application

Let's see what happens when we start up a default Rails application. Since we configured our app to connect to a PostgreSQL database, we need to create a blank database if it does not already exist:

```no-highlight
$ rake db:create
```

Once that command finishes we can startup our server using the `rails` command:

```no-highlight
$ rails server --binding=0.0.0.0

=> Booting WEBrick
=> Rails 4.2.0 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2015-03-17 15:50:04] INFO  WEBrick 1.3.1
[2015-03-17 15:50:04] INFO  ruby 2.2.0 (2014-12-25) [x86_64-linux]
[2015-03-17 15:50:04] INFO  WEBrick::HTTPServer#start: pid=32091 port=3000
```

Rails uses WEBrick as the default web server will listen on port 3000 unless otherwise specified. Visiting [http://localhost:3000](http://localhost:3000) will display the Rails welcome message until we specify a new home page. To shut down the server send an interrupt signal by pressing `Ctrl` + `C`.

### Viewing Articles

Right now our application doesn't do anything useful. We've setup the structure for a Rails app but we haven't customized it for our needs. Let's add the ability to view a list of links to news articles so we can see which files we need to add and modify.

We'll refer to the articles as a **resource** for this discussion. Whenever we want to add a completely new resource, whether it's articles, users, comments, etc., we'll follow a similar series of steps:

1. Define the URL endpoints for accessing this resource. For now we'll start with `/articles` for viewing a list of articles.
2. Add a controller for handling incoming requests targeted at that resource. The controller will be responsible for retrieving the articles from the database and passing them into the corresponding view.
3. Add a view to display the resource. We'll display the list of articles as an unordered list within an HTML document.
4. Create a model to retrieve articles from the database.
5. Create a migration to update the database schema so it has a place to store the articles.

To start, let's try visiting [http://localhost:3000/articles](http://localhost:3000/articles) and see what error message we get:

```no-highlight
Routing Error
No route matches [GET] "/articles"
```

We need to instruct our application that `/articles` is a valid endpoint. Replace the comments in `config/routes.rb` with the following code:

```ruby
Rails.application.routes.draw do
  resources :articles, only: [:index]
end
```

If we refresh [http://localhost:3000/articles](http://localhost:3000/articles) we should get a different error this time:

```no-highlight
Routing Error
uninitialized constant ArticlesController
```

Notice how we didn't have to restart the server. Rails will check for updated files and reload them if they are changed. The only exceptions to this are if we include new libraries in our Gemfile or if we change a file in the `config/initializers` directory.

Back to the error message, we notice that it is looking for a controller. When a URL matches a route, Rails will attempt to find the corresponding controller to handle that request. Since we defined an articles resource, it will look for an articles controller.

Add a file `app/controllers/articles_controller.rb` with the following contents:

```ruby
class ArticlesController < ApplicationController
  def index
  end
end
```

Verify that the file and class names are both pluralized otherwise Rails won't be able to find it. Refreshing the page should yield a new error:

```no-highlight
Template is missing
Missing template articles/index
```

Our controller is handling the request but it can't find an associated view to use. Since we're calling the `index` action on the `articles` controller, we need to define our view in `app/views/articles/index.html.erb`. First create the directory and file we need:

```no-highlight
$ mkdir -p app/views/articles
$ touch app/views/articles/index.html.erb
```

Within the `index.html.erb` file add the following:

```HTML+ERB
<h1>Articles</h1>

<ul>
  <% @articles.each do |article| %>
    <li><%= link_to article.title, article.url %></li>
  <% end %>
</ul>
```

This view displays the articles in an unordered list and generates a link for each one. We're using an instance variable `@articles` to pass information from the controller to the view and generating the link using the `link_to` helper method. Let's update our controller to retrieve the list of articles and store them in the instance variable:

```ruby
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
end
```

If we refresh [http://localhost:3000/articles](http://localhost:3000/articles) we'll get a new error message:

```no-highlight
NameError in ArticlesController#index
uninitialized constant ArticlesController::Article
```

Now it is complaining that it cannot resolve the reference to `Article.all`. This means we need to define an ActiveRecord model that will retrieve the articles from the database in `app/models/article.rb` (note that the file and class name is _singular_ for models):

```ruby
class Article < ApplicationRecord
end
```

If we take a peek in `app/models/application_record.rb`, we will see:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

Essentially, our Article class end up inheriting from `ActiveRecord::Base`.

Now that we have our model, refresh again to get the next error:

```no-highlight
ActiveRecord::StatementInvalid in Articles#index
PG::UndefinedTable: ERROR:  relation "articles" does not exist
LINE 1: SELECT "articles".* FROM "articles"
```

This error message is telling us that we have a model but it does not have a corresponding table in the database. For this we'll need to create a migration to update our database schema. Because migration files are prefixed with the current timestamp, let's rely on the `rails` command-line tool to generate a migration for us with the correct filename:

```no-highlight
$ rails generate migration create_articles
 invoke  active_record
 create    db/migrate/20150317205225_create_articles.rb
```

We can then edit the `db/migrate/20150317205225_create_articles.rb` file to create our articles table with a title and a URL:

```ruby
class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :url, null: false, length: 1000

      t.timestamps
    end
  end
end
```

We also include the `t.timestamps` to insert the `created_at` and `updated_at` columns that store when the row was first created and last updated. Let's go ahead and run the migration to create the table:

```no-highlight
$ rake db:migrate
== 20150317205225 CreateArticles: migrating ===================================
-- create_table(:articles)
   -> 0.0200s
== 20150317205225 CreateArticles: migrated (0.0201s) ==========================
```

Now if we visit [http://localhost:3000/articles](http://localhost:3000/articles) we should be presented with an empty list of articles. To make it more interesting lets insert some sample data. We can load our Rails environment in an IRB session using the `rails console` command:

```no-highlight
$ rails console
Loading development environment (Rails 4.2.0)

> Article.create!(title: "Reddit", url: "https://www.reddit.com/")
> Article.create!(title: "Hacker News", url: "https://news.ycombinator.com/")
> Article.create!(title: "The Daily Programmer", url: "http://www.reddit.com/r/dailyprogrammer")
```

The `Article.create!` method will insert records into the database using the ActiveRecord model. When we refresh [http://localhost:3000/articles](http://localhost:3000/articles) we should see the three articles that we just inserted.

### In Summary

In this article we've briefly toured the Rails framework and looked at the file structure of a Rails application. The `rails new` command will generate a new application from a template and install any dependencies we need.

Although a Rails application includes many files by default, most of the work is done in the **app** directory where we define our models, views, and controllers. Other important directories include **config** where we define application settings and **db** where we can define migrations.

The `rails console` command allows us to enter an IRB session with the application loaded. This enables us to access the models and other classes directly in case we want to access our database via ActiveRecord or test out new methods interactively.