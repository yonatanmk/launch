require "sinatra"
require "pry"
require "csv"


set :bind, "0.0.0.0"
set :views, File.join(File.dirname(__FILE__), "views")


get "/" do
  redirect to("/books")
end

get "/books" do
  @books = []
  CSV.foreach(csv_file, headers: true) do |row|
    @books << row.to_h
  end
  erb :"books/index"
end

get "/books/new" do
  erb :"books/new"
end

post "/books/new" do
  title = params["title"]
  author = params["author"]
  genre = params["genre"]
  if [title, author, genre].include?("")
    @error = true
    erb :"books/new"
  else
    CSV.open(csv_file, "a", headers: true) do |csv|
      csv << [params["title"], params["author"], params["description"]]
    end
    redirect "/books"
  end
end


# Helper Methods

def csv_file
  if ENV["RACK_ENV"] == "test"
    "data/books_test.csv"
  else
    "data/books.csv"
  end
end

def reset_csv
  CSV.open(csv_file, "w", headers: true) do |csv|
    csv << ["title", "author", "genre"]
  end
end
