In this article we'll begin to work with associations in ActiveRecord.

### Learning Goals

* Create a multi-table application
* Explore ways to associate tables
* Use a foreign key column

### Database Relationships

In a family, a parent has zero or more children; a directory on a hard drive contains zero or more files; a house contains one or more rooms. We intuitively understand the hierarchical nature of these relationships.

This type of relationship often comes up in our data as well. A blog has one or more articles; an article has zero or more comments; a user has zero or more comments. These are known as **one-to-many** relationships and in this assignment we'll begin to look at how to represent these relationships in our applications.

### Enter the Blogosphere

![Entity-Relationship Diagram for articles and comments](https://s3.amazonaws.com/horizon-production/images/erd-articles-comments.png)

Let's create a new Sinatra app. We can use the [Sinatra ActiveRecord Starter Kit](https://github.com/LaunchAcademy/sinatra-activerecord-starter-kit) as a base for our app. Follow the instructions in the [Getting Started](https://github.com/LaunchAcademy/sinatra-activerecord-starter-kit#getting-started) section of the README, calling the app "blog".

**Hint: Don't forget to create your database with `rake db:create` after configuring your database.**

### Creating Articles

To begin, we'll create an `Article` model:

```ruby
# app/models/article.rb

class Article < ActiveRecord::Base
end
```

For every model in our `app/models` folder, we need an associated table in our database. Let's create a migration to handle creating the corresponding `articles` table with `rake db:create_migration NAME=create_articles`.

Inside the generated `db/migrate/YYYYMMDDHHMMSS_create_articles.rb` file:

```ruby
# db/migrate/YYYYMMDDHHMMSS_create_articles.rb

class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |table|
      table.string :subject, null: false
      table.text :story, null: false

      table.timestamps null: false
    end
  end
end
```

After creating our database and running `rake db:migrate`, we should have our `articles` table.

### Creating Comments

We also want to let people comment on our articles, which we'll store in a separate `comments` table. A comment should have some text associated with it but it also needs to be associated with a article, somehow. We can accomplish this by creating a **foreign key** from our `comments` table back to our `articles` table.

To begin, we'll create a `Comment` model:

```ruby
# app/models/comment.rb

class Comment < ActiveRecord::Base
end
```

And then we'll create a migration to handle creating the corresponding `comments` table in the database with `rake db:create_migration NAME=create_comments`.

Inside the generated `db/migrate/YYYYMMDDHHMMSS_create_comments.rb`:

```ruby
# db/migrate/YYYYMMDDHHMMSS_create_comments.rb

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |table|
      table.integer :article_id, null: false
      table.text :body, null: false

      table.timestamps null: false
    end
  end
end
```

**Migrate the database again to finish creating the `comments` table.**

Notice how we included the `article_id:integer` attribute in our model. The `article_id` column on the `comments` table refers to the `id` column on the `articles` table. In this scenario, `article_id` is the _foreign key_ and `id` is the _primary key_. This enables us to have a single record in the `articles` table that corresponds to zero or more records in the comments table.

### Creating Some Records

Let's load up our app in an irb (or pry if you want syntax highlighting!) console session and create some records in our database.

**You can fire up an irb session and require all of your app with `irb -r ./app.rb`.**

Run the following commands in your irb session:

```ruby
cat_article = Article.create(subject: "Some thoughts about cats", story: "They're OK.")
ruby_article = Article.create(subject: 'Ruby vs. Python', story: 'Ruby wins cause I said so.')

Comment.create(body: 'LOL', article_id: cat_article.id)
Comment.create(body: 'click here for a free iPad!', article_id: cat_article.id)

Comment.create(body: 'great analysis!!!', article_id: ruby_article.id)
Comment.create(body: 'ruby is so 2010, Go is the future', article_id: ruby_article.id)
Comment.create(body: 'i like ice cream', article_id: ruby_article.id)
```

Notice that when we created a comment, all we had to do was give it the ID of the article that it belonged to so that the foreign key was setup correctly.

### Retrieving Associated Records

A very common operation in ActiveRecord is to start with a single record, and then retrieve a list all of its associated records (e.g. find a user and list all of their friends, find a movie and list all of the cast, etc.). Let's write a Ruby method, utilizing SQL, to find all of the comments associated with a single article.

```ruby
class Article < ActiveRecord::Base
  def comments
    sql = "SELECT * FROM comments WHERE article_id = #{id}"
    Comment.find_by_sql(sql)
  end
end
```

We can do better than this. ActiveRecord contains query methods that allow us to avoid writing SQL, so we can focus on working in the universe of Ruby objects. We can utilize the `where` method to look up the comments for an article:

```ruby
article = Article.where(subject: 'Some thoughts about cats').first
comments = Comment.where(article_id: article.id)
```

We first retrieve the article based on the subject using our `where(subject: 'Some thoughts about cats').first` method and then we query for comments using `where(article_id: article.id)`. We're first finding the **primary key** of the article and then matching that to the **foreign key** on the comments table.

**Quick challenge:** Retrieve the article associated with the comment "i like ice cream".

Now, let's rewrite the `comments` method on the article class to use the `where` method:

```ruby
class Article < ActiveRecord::Base
  def comments
    Comment.where(article_id: id)
  end
end
```

Associations such as these are a very common occurrence. So much so, that the developers of ActiveRecord added ways to shortcut the writing of methods such as the one above. We can use [ActiveRecord Associations](http://guides.rubyonrails.org/association_basics.html) to make the process of retrieving associated records much easier.

### Using ActiveRecord associations

ActiveRecord provides a number of different types of associations. Here, we'll look at two associations that are used to establish a one-to-many relationship: [has_many](http://guides.rubyonrails.org/association_basics.html#the-has-many-association) and [belongs_to](http://guides.rubyonrails.org/association_basics.html#the-belongs-to-association).

#### has_many

In our `Article` model, we can let ActiveRecord know about the one-to-many relationship:

```ruby
class Article < ActiveRecord::Base
  has_many :comments
end
```

The `has_many` method will set up our association between the `Article` and the `Comment` model. By saying that `article` "has many" comments, it is expecting to find a model named `Comment` that has a `article_id` attribute.

We can test our new association by loading up our app in an irb session and running the following command:

```ruby
article = Article.first
article.comments
```

The line `article.comments` will return the same records that `Comment.where(article_id: article.id)` returns. By following conventions (i.e. naming our foreign key `article_id` after the model name), we can benefit from these shortcuts that Rails provides.

#### belongs_to

In addition to a `Article` having many `Comment`s, a `Comment` also has the inverse relationship with its `Article`. Given a `Comment`, we can find the `Article` that it belongs to using the following:

```ruby
comment = Comment.first
article = Article.where(id: comment.article_id).first
```

With ActiveRecord, we can define this relationship to make querying for the `article` a bit easier.

```ruby
class Comment < ActiveRecord::Base
  belongs_to :article
end
```

Here we've defined the relationship between our `Comment` and the `Article`: the `Comment` belongs to the `Article`. Doing this provides the `Article` method on instance of the `Comment` class for easy lookup:

```ruby
comment = Comment.first
comment.article
```

This returns the same record as `Article.where(id: comment.article_id).first` did except we have to use far less syntax. ActiveRecord makes manipulating our records much simpler to the point where we don't have to deal with SQL on a regular basis and can instead focus on using our objects and the relationships between them.

Whenever we define a `has_many` association, there should be a corresponding `belongs_to` association. If an article has many comments, it follows that a comment belongs to an article. We should define the association `has_many :comments` in the `Article` model **and** define the `belongs_to :article` association in the `Comment` model. You should not declare one without the other.

Declaring associations between our ActiveRecord models gives us a host of methods to help with the creation and retrieval of related objects. For instance, declaring that an article `has_many :comments` gives us the following methods on the `Article` class: `Article#comments.empty?`, `Article#comments.size`, `Article#comments`, `Article#comments<<(comment)`, `Article#comments.delete(comment)`, `Article#comments.destroy(comment)`, `Article#comments.find(comment_id)`, `Article#comments.build`, `Article#comments.create`

Read more about the methods we get for 'free', here: [`ActiveRecord::Associations::ClassMethods`](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html).

### Throw away `_id` and `.id`

Now that we are moving towards a solid understanding of ActiveRecord, it's time to take the training wheels off. Notice that when we created our tables, we didn't have to specify a primary key. This was created for us. When assigning relationships in ActiveRecord, we should use the methods provided for us. For example:

```
ruby_article = Article.create(subject: 'Ruby vs. Python', story: 'Ruby wins cause I said so.')

# don't do this
# Comment.create(body: 'LOL', article_id: ruby_article.id)

# do this
Comment.create(body: 'LOL', article: ruby_article)
```

The difference is subtle: In the first scenario, we are relying on the primary key/foreign key relationship within the database to create our association. In the second scenario, we are utilizing the tools ActiveRecord gives us to create an association between Ruby objects.

**Quick Challenge**: Refactor your code to omit the use of `_id` and `.id` where possible.

### Primary & Foreign Keys

SQL doesn't actually require that we use numeric integers for foreign keys but for our applications it is usually the preferred method. We could have also linked our comments to the articles via the subject line if we wanted to: instead of `article_id` we could have used `article_subject` where we stored the subject of the article with each comment. The problem is that the author might edit the subject at some point and break that link between the article and the comments. It's best to stick with using numeric IDs that are auto-assigned by the database. These IDs are never re-used or changed once they are assigned so it ensures that the relationships between objects do not get mixed up.

### `has_many` and `belongs_to`

These two class methods provide us with the ability to link our models together, provided we have named our tables and columns according to Rails conventions. These methods are very similar to the `attr_reader`, `attr_writer`, and `attr_accessor` class methods that are defined in Ruby, in that they keep us from having to write repetitive code for common operations.

### Resources

* [Rails Guide to ActiveRecord Associations](http://guides.rubyonrails.org/association_basics.html)
* [ActiveRecord::Associations::ClassMethods](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)

### In Summary

The most striking thing about associations is how readable they make relationships between objects. Once you become acclimated to their use, you'll start to examine models by looking at how their declared associations work, their relations to dependents, as well as their validations and scopes. A single line of code in a model can tell you an enormous amount about a database relationship.
