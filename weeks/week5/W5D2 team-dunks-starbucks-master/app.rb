require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'

enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces

configure :development, :test do
  require 'pry'
end

configure do
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

def dunks_members
  dunks_members = []
  @members.each do |member|
    if member.team == "Dunks"
      dunks_members << member
    end
  end

  return dunks_members

end

def starbucks_members
  starbucks_members = []
  @members.each do |member|
    if member.team == "Starbucks"
      starbucks_members << member
    end
  end

  return starbucks_members

end

get '/' do
  redirect '/teams'
end

get '/teams' do
  @members = Member.all
  erb :index
end

post '/teams' do
  @member = Member.create(name: params['name'], team: params['team'])
  @members = Member.all
  erb :index
end
