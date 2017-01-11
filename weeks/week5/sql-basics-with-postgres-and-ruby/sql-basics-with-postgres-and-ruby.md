### Introduction

We've seen the basics of how to use SQL to communicate with a PostgreSQL
database using the `psql` tool, but how do we incorporate that into our Ruby
applications? In this article we'll look at how to interact with a PostgreSQL
database from our Ruby programs.

### Learning Goals

* Install and use the Ruby `pg` gem.
* Interact with a PostgreSQL database from IRB.
* Interact with a PostgreSQL database from a Ruby program.
* Sanitize user input to prevent SQL injection attacks.

### SQL and Ruby

Before we can issue a SQL command we need to open a connection to the database
server. The `pg` gem is a Ruby library that enables us to communicate with a
PostgreSQL server. To install this gem, run the following command:

```no-highlight
$ gem install pg
```

Now we can try querying the database in an IRB session:

```no-highlight
> require "pg"
 => true

> connection = PG.connect(dbname: "todo")
 => #<PG::Connection>

> results = connection.exec("SELECT id, name FROM tasks")
 => #<PG::Result>

 > results.to_a
 => [{"id"=>"1", "name"=>"learn SQL"},
     {"id"=>"2", "name"=>"become great"},
     {"id"=>"3", "name"=>"win at Launch Academy"}]

> connection.close
 => nil
```

First we have to load the library in memory using the `require "pg"` statement.
The `PG.connect` method will open a connection to the server which we can then
use to send SQL statements. When we call the `exec` method on the connection, we
pass in the SQL statement we want to execute and we're returned the results from
the server. The results are returned as a `PG::Result` object but it behaves
very similarly to an array of hashes, which we can see by calling the `to_a`
method. Whenever we're finished with a connection we'll want to close it (using
the `close` method).

IRB is nice, but what we really want is to be able to interact with our database
from our Ruby programs. To do this, we must follow the same general steps as above:
1. Require the pg gem: `require "pg"`.
2. Open a connection to our database: `connection = PG.connect(dbname: "name").`
3. Issue our SQL commands.
4. Close the connection: `connection.close`.

Since we'll be using our database connection frequently, let's define our own
method that handles automatically opening and closing a connection to the `todo`
database:

```ruby
require "pg"

def db_connection
  begin
    connection = PG.connect(dbname: "todo")
    yield(connection)
  ensure
    connection.close
  end
end
```

The `PG.connect` and `connection.close` statements are typical method calls, but
what do the `yield(connection)` and `begin..ensure` statements do?

The `yield(connection)` statement allows this method to accept a block of code
(in the form of a `do..end` or `{..}` block) that can be run in the middle of
the method. If we wanted to use this method to query for a list of tasks, we
might write something like:

```ruby
tasks = nil

db_connection do |conn|
  tasks = conn.exec("SELECT name FROM tasks")
end

tasks.to_a.each do |task|
  puts task["name"]
end
```

Notice how the `do..end` block accepts a single parameter: the `conn`
parameter is assigned the value passed into `yield(connection)`. Within this
block we can use the connection to query the database (by calling the `exec`
method).

Once this block of code is finished, execution picks up right after the `yield`
statement. We wrap up the method with an `ensure..end` block that closes out the
connection. The reason we use `ensure` is that this code is guaranteed to run:
even if an exception is thrown or something else goes wrong, the `ensure` block
will guarantee that the code for closing the connection will get run.

### User Input

The SQL statement we used to query all of the tasks uses a fixed format: we just
ask for the name of all rows in the _tasks_ table. In other cases our SQL will
contain parameters that will vary based on user input. Consider a statement to
insert a new task based on user input:

```SQL
INSERT INTO tasks (name) VALUES ('buy milk');
```

If a user typed _buy milk_ into an HTML form and submitted it, we could generate
the SQL statement using string interpolation in Ruby:

```ruby
# params["task_name"] => "buy milk"
sql = "INSERT INTO tasks (name) VALUES ('#{params["task_name"]}')"
# => "INSERT INTO tasks (name) VALUES ('buy milk')"

db_connection do |conn|
  conn.exec(sql)
end
```

This might work for most use cases, but what happens when the user types in
_initiate coup d'etat_:

```ruby
# params["task_name"] => "initiate coup d'etat"
sql = "INSERT INTO tasks (name) VALUES ('#{params["task_name"]}')"
# => "INSERT INTO tasks (name) VALUES ('initiate coup d'etat')"
# The extra quote breaks this SQL statement -----------^

db_connection do |conn|
  conn.exec(sql)
end
```

When we try to run this SQL statement our database will complain about an
invalid SQL statement. The single quote within _initiate coup d'etat_ closes the
string too early and breaks the statement.

At best our database refuses to run the statement because it is invalid SQL. At
worst an attacker can exploit this vulnerability to insert specially crafted SQL
fragments to run malicious code in our database. What would our SQL look like if
the user input `a'); DROP TABLE tasks; --`. Note that `--` starts a comment in
SQL. This particular attack is known as [SQL
Injection](http://en.wikipedia.org/wiki/SQL_injection) and is a common malicious
attack performed on websites.

![Little Bobby Tables](https://imgs.xkcd.com/comics/exploits_of_a_mom.png)

[Source](https://xkcd.com/327/)

To prevent this we want to **sanitize** any input that we accept from users and
**escape** special characters like `'` so they don't interfere with the
structure of our SQL. We can use *placeholders* within a query and then provide
values for those placeholders that get filtered for any malicious characters
before they are inserted into the statement. The `exec_params` method will
perform this filtering for us:

```ruby
db_connection do |conn|
  conn.exec_params("INSERT INTO tasks (name) VALUES ($1)", [params["task_name"]])
end
```

`exec_params` take two arguments:

1. The SQL query that we want to execute
2. An array of information that we need to sanitize. We call this array `params`
(Don't get confused with Sinatra `params`, that `params` is a hash!)

The previously mentioned placeholder in the example above is the `$1` symbol.
This symbol gets replaced by the first argument in the params array when the SQL query gets executed.


If we needed to insert two pieces of data, we could place a `$2` symbol into the query, and then define a second element in the `params` array.

```ruby
db_connection do |conn|
  @event = conn.exec_params(
    "INSERT INTO events (name, start_time) VALUES ($1, $2)",
    ["Romeo and Juliet", "8:00PM"]
  )
end
```

To summarize: If the user input contains any special characters (e.g. the `'` quote) then `exec_params` method will properly enclose those values so that it does not break the SQL statement.
By using this method, we don't have to worry (too much) about sanitizing our inputs.
The `pg` gem does a great job of doing this task for us!

### SQL-backed TODO Application

Let's return to the TODO application that was built in the "HTTP POST and
HTML Forms" article and use PostgreSQL to store the list of tasks.

Within the _server.rb_ file there are two places where we're either reading
tasks from or writing tasks to a file:

```ruby
get "/tasks" do
  # Reading from a file here...
  @tasks = File.readlines("tasks.txt")
  erb :index
end

post "/tasks" do
  task = params["task_name"]

  # Writing to a file here...
  File.open("tasks.txt", "a") do |file|
    file.puts(task)
  end

  redirect "/tasks"
end
```

We need to modify these two routes to read from and write to the _todo_ database
instead of the _tasks.txt_ file. We'll first need to include the **pg** gem and
also define our helper method that will open and close the database connection
for us:

```ruby
require "sinatra"
require "pg"

set :bind, '0.0.0.0'  # bind to all interfaces

def db_connection
  begin
    connection = PG.connect(dbname: "todo")
    yield(connection)
  ensure
    connection.close
  end
end
```

Now in our `get "/tasks"` and `post "/tasks"` routes we can use our database
connection in place of the file:

```ruby
get "/tasks" do
  # Retrieve the name of each task from the database
  @tasks = db_connection { |conn| conn.exec("SELECT name FROM tasks") }
  erb :index
end

post "/tasks" do
  task = params["task_name"]

  # Insert new task into the database
  db_connection do |conn|
    conn.exec_params("INSERT INTO tasks (name) VALUES ($1)", [task])
  end

  redirect "/tasks"
end
```

Now whenever a user submits a task, it will be saved to our _todo_ database. One
difference with this code is that when we query for the list of tasks we
actually get back an array of hashes instead of an array of strings:

```ruby
# Returns a PG::Result object which behaves like an array of hashes
@tasks = db_connection { |conn| conn.exec("SELECT name FROM tasks") }
```

We can either extract the task names in the controller or we can update our
_views/index.erb_ file to handle the new data type:

```erb
<ul>
  <% @tasks.each do |task| %>
    <li>
      <a href="/tasks/<%= task["id"] %>">
        <%= task["name"] %>
      </a>
    </li>
  <% end %>
</ul>
```

Since `task` is not a string but a Hash-like object, we extract the name by
referring to `task["name"]`.

**NOTE:** We are using the `id` attribute to create the link.
Now that we are using database, we wan't to use these ids because they are
guaranteed to be unique.

### In Summary

To use an RDBMS in our Ruby applications we can utilize the **pg** gem. To issue
a SQL statement we first have to open a **connection** to the database and then
submit the statement to be executed. The results of a query are returned as an
array of hashes. We must then close the **connection** when we are finished.

If a SQL statement contains user input it should be **sanitized** before being
sent to PostgreSQL. Unsanitized input can lead to **SQL injection** attacks that
enable malicious users to run arbitrary statements against our database.

### Resources

* [PG Gem README](https://deveiate.org/code/pg/README_rdoc.html)
