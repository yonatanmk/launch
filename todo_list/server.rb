require "sinatra"

set :bind, '0.0.0.0'  # bind to all interfaces
set :public_folder, File.join(File.dirname(__FILE__), "public")

get "/hello" do
  "<p>Hello, world! The current time is #{Time.now}.</p>"
end

get "/tasks" do
  @tasks = File.readlines("tasks.txt")
  erb :index
end

post "/tasks" do

  task = params["task_name"]

  File.open("tasks.txt", "a") do |file|
    file.puts(task)
  end
  redirect "/tasks"
end

get "/tasks/:task_name" do
  @task_name = params[:task_name]
  erb :show
end
