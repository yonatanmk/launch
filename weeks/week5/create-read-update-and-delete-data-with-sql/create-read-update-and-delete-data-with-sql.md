### Introduction

Postgres is an implementation of a **Relational Database Management System**
(RDBMS) which we will use to store information for the Web Applications which we
will build. It supports the **Structured Query Language** (SQL), which is a common
language supported by many other relational database systems. **SQL** allows us
to perform CRUD actions on data within a database.

### Learning Goals

* Create a new **database**, which is a container for related **tables**.
* Define the **schema** for a database, which describes the column names within
  tables, and their associated **data types**.
* Introduce the concept of **primary keys**.
* Learn how to create, read, update, and delete records using Structured Query
  Language, or **SQL**.

### Creating a Database

In order to start working with a Database, we need to create one:

```no-highlight
$ createdb music_brain
```

The `createdb` command allows us to create a new Postgres database. Other
relational databases, such as
[MySQL](http://dev.mysql.com/doc/refman/5.7/en/creating-database.html)
or
[sqlite](https://www.sqlite.org/quickstart.html),
have a slightly different syntax for creating new databases. This is less
relevant at the moment, since we will be using Postgres throughout our
curriculum. However, this information will become very important later in your
career, when you start working with different relational database systems.

### Creating a Table

![Image of the songs table in pgAdmin3](https://s3.amazonaws.com/horizon-production/images/songs-table.png)

A **table** is a place for us to store data. It consists of **rows**, **columns**,
and **cells** (the intersection of a row and column). In the above image, we have 
the contents of the `songs` table, which we will build in this lesson. 

A **row**, also called a **record**, is an individual entry in our database. In this
case, a song. 

A **column** describes a characteristic of our data. Such as the artist, the year the 
song was released, and the album it first appeared on.

Before we can start inserting data into the table, we need to describe the
**schema** of the table. The schema answers the following questions about our
data: What is the name of the table? What are the names of the columns? What
type of data is going to go in a column?

Let's create a `songs` table which will have the following columns:

```no-highlight
id
artist
album
title
year
length_in_seconds
created_at
updated_at
```

So, these are the columns we want to define. What datatypes should these columns
be?

### Datatypes

We must declare the datatypes for our columns before we can start adding data
to our database. This concept is known as **static typing**.

| Datatype   | Description                            |
| ---------- | -------------------------------------- |
| boolean    | logical Boolean (true/false)           |
| varchar(n) | variable-length character string       |
| date       | calendar date (year, month, day)       |
| integer    | signed four-byte integer               |
| real       | single precision floating-point number |
| serial     | auto-incrementing four-byte integer    |
| text       | variable-length character string       |
| timestamp  | date and time                          |

These are the datatypes we tend to use the most. You may have a need for
[other datatypes](http://www.postgresql.org/docs/9.4/static/datatype.html)
at some point. It's good to know where to look up this information for future
reference.

### Defining our Table's Schema

Now that we are familiar with the available datatypes we have at our disposal,
we can open up our database and define the schema with the `CREATE TABLE` command.

```no-highligh
$ psql music_brain
```

```sql
CREATE TABLE songs(
  id SERIAL PRIMARY KEY,
  artist VARCHAR(255),
  album VARCHAR(255),
  title VARCHAR(255) NOT NULL,
  year INTEGER,
  length_in_seconds INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

A few things to note, here.

The capitalization of SQL keywords is a convention. It helps us to differentiate
between the table names, column names, and SQL keywords when syntax highlighting
is not available.

The identification of a **primary key** in a table is equivalent to saying
"this field is unique for all records in the table". In this case, we are using
an auto-incremented integer to be our **primary key**. Having a unique
identifier for every record in our table is a useful convention. We can simply 
pass around the id and table name within our application, and easily look up that 
record.

The addition of a `NOT NULL` **constraint** to our `title` column makes it so
that this field is required. It doesn't make much sense to create a record in
our `songs` table if the title of the song isn't present. It is possible to 
add [other constraints](https://www.postgresql.org/docs/9.4/static/ddl-constraints.html)
to your table, such as declaring that a column must contain unique data.

Another useful convention is the addition of the `created_at` and `updated_at`
timestamps. By changing these fields when we create a new record, or update
and existing record, we can keep tabs on _when_ our data has been modified.
Note, these fields are not always necessary, but you will see them used quite
frequently.

### Inserting data into our Table (Create)

The SQL insert statement will allow us to add rows to our database. Let there be
data!

```sql
INSERT INTO songs(artist, album, title, year, length_in_seconds, created_at, updated_at)
VALUES
  ('Iggy Pop', 'Lust for Life', 'The Passenger', 1977, 281, NOW(), NOW()),
  ('David Bowie', 'Golden Years', 'Golden Years', 1975, 241, NOW(), NOW()),
  ('Primal Scream', 'Screamadelica', 'Come Together', 1991, 265, NOW(), NOW()),
  ('joy division', 'Licht und Blindheit', 'Atmosphere', 1980, 251, NOW(), NOW()),
  ('The Creation', 'We Are Paintermen', 'Making Time', 1967, 175, NOW(), NOW()),
  ('Cat Stevens', 'Matthew and Son', 'Here Comes My Baby', 1967, 176, NOW(), NOW()),
  ('Faces', 'Ooh La La', 'Ooh La La', 1973, 212, NOW(), NOW()),
  ('Squarepusher', 'Go Plastic', 'Tommib', 2001, 81, NOW(), NOW()),
  ('My Bloody Valentine', 'Loveless', 'Sometimes', 1991, 319, NOW(), NOW()),
  ('Air', 'Talkie Walkie', 'Alone in Kyoto', 2004, 290, NOW(), NOW()),
  ('The Psychedelic Furs', 'Talk Talk Talk', 'Pretty in Pink', 1981, 282, NOW(), NOW()),
  ('New Order', 'Low-Life', 'Shellshock', 1985, 366, NOW(), NOW()),
  ('Echo and the Bunnymen', 'Echo and the Bunnymen', 'Bring on the Dancing Horses', 1987, 237, NOW(), NOW());
```

Note that we do not specify the `id` for our entries. We let the database handle
that task for us. Also, if we are going to change a record, we should also
update the `updated_at` field of the record so that we know the data changed.

Also note that single and double-quotes cannot be used interchangeably.
**Use single-quotes for strings in SQL**.

**Quick Challenge:** Add one or more of your favorite songs to the `songs` table.

### Retrieving data from our Table (Read)

We can now get all the records

```sql
SELECT * FROM songs;
```

Or, just one

```sql
SELECT * FROM songs WHERE id = 7;
```

We can also choose to select specific fields, if we do not want all the
information about a particular song.

```sql
SELECT artist, title FROM songs WHERE id = 7;
```

### Caveats When Working with `psql`

> My terminal is stuck. I can't type anything and there is a colon `:` at the
> bottom of the screen.

When you perform a query in `psql`, the results will be returned using a
"terminal pager" called [`less`](https://en.wikipedia.org/wiki/Less_(Unix)),
so that your screen isn't flooded with a wall of text. Press `h` to get a
rundown of the commands. Press `q` to quit. If you would like to turn off the
paging feature, create the following file in your home directory, then, restart
your terminal.

```no-highlight
# ~/.psqlrc
\pset pager off
```

---

> I typed in the query, but nothing happened.

You probably forgot a semicolon at the end of your SQL statement `;`. SQL
statements can span multiple lines. If you see a minus sign in the psql prompt,
this means you are in the middle of a SQL statement.

```no-highlight
music_brain=# SELECT * FROM songs
music_brain-#
music_brain-#
music_brain-#
music_brain-# ;  -- <-- end of SQL statement.
```

---

> The output looks terrible!

```no-highlight
music_brain=# SELECT * FROM songs;

id |        artist         |         album         |            title           
 | year | length_in_seconds |         created_at         |         updated_at
----+-----------------------+-----------------------+---------------------------
--+------+-------------------+----------------------------+---------------------
-------
 1 | Iggy Pop              | Lust for Life         | The Passenger              
  | 1977 |               281 | 2016-09-06 14:00:34.002373 | 2016-09-06 14:00:34.
  002373
 2 | David Bowie           | Golden Years          | Golden Years               
  | 1975 |               241 | 2016-09-06 14:00:34.002373 | 2016-09-06 14:00:34.
  002373
 3 | Primal Scream         | Screamadelica         | Come Together              
  | 1991 |               265 | 2016-09-06 14:00:34.002373 | 2016-09-06 14:00:34.
  002373
 4 | joy division          | Licht und Blindheit   | Atmosphere                 
  | 1980 |               251 | 2016-09-06 14:00:34.002373 | 2016-09-06 14:00:34.
  002373
 5 | The Creation          | We Are Paintermen     | Making Time                
  | 1967 |               175 | 2016-09-06 14:00:34.002373 | 2016-09-06 14:00:34.
  002373
 6 | Cat Stevens           | Matthew and Son       | Here Comes My Baby         
  | 1967 |               176 | 2016-09-06 14:00:34.002373 | 2016-09-06 14:00:34.
  002373
-- ...
```

Above line length is truncated to 80 characters.

To get around this, you can change the font size of your terminal (`CMD + =`,
`CTRL + =`), or you can select fewer columns. `SELECT id, title FROM songs;`.

Either is an effective solution.


### Modifying data in our Table (Update)

One of our proper nouns is lacking proper capitalization. Let's fix that.

```sql
UPDATE songs
SET artist = 'Joy Division', updated_at = NOW()
WHERE artist = 'joy division';
```

We can check our work with a query.

```sql
SELECT * FROM songs;
```

### Removing data from our Table (Delete)

Perhaps there is a song we are not very fond of. Let's get rid of it.

```sql
DELETE FROM songs
WHERE id = 6;
```

Check that the deletion actually happened.

```sql
SELECT * FROM songs;
```

To exit from the `psql` prompt, use the quit command.

```no-highlight
\q
```

### Wrap Up

We have explored how to create a database, how to create a table in that
database by modifying the database schema, and how to perform CRUD actions (Create, Read,
Update, Delete) on data within a database.
