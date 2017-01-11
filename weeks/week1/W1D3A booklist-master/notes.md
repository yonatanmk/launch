Title: The Martian
Author: Andy Weir
Genre: Science Fiction


#form
```html

<h3>New Book</h3>

<form action="/books" method="post">
  <label for="title">Title</label>
  <input id="title" name="title" type="text" />

  <label for="author">Author</label>
  <input id="author" name="author" type="text" />

  <label for="genre">Genre</label>
  <input id="genre" name="genre" type="text" />

  <button type="submit">Submit</button>
</form>

```

#save
```ruby
CSV.open(csv_file, "a", csv_options) do |csv|
  csv << [title, author, description]
end
```
