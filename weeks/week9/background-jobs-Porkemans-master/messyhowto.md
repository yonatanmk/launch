# Sidekiq Setup


### Redis Setup
- brew install redis
- redis-server
    - port 6379
- add “gem ‘sidekiq’"
    - comes with web ui
    - built in sinatra.
        - gem ‘sinatra’, github: ‘sinatra/sinatra'
            - bundle from source to avoid dependency issues
    - bundle
- boot up rails
- mount sidekiq on routes
    - ~routes.rb
        - require ‘sidekiq/web'
        - mount Sidekiq::Web => “/sidekiq"

### Sidekiq worker
- mkdir app/workers
    - a worker is ALOT like a job, but has some added Sidekiq functionality
    - touch email_worker.rb
    - ReportWorker.rb
- Review PokemonsControler
- See how the setup can be viewed locally
    - redis server, sidekiq server, sidekick dashboard, watching the logs

### Heroku setup
- Edit Procfile
    - report worker: bundle exec sidekiq -c 1
    - push to heroku
        - git
        - git push heroku master
- Heroku Addons
    - add ons under resources
        - just add RedisToGo
        - this provides a redis url
- ENV variables
    - set redis_provider to redistogo_url
- setup dyno for our worker
    - heroku ps:scale reportworker=1
- See how it runs
- heroku logs -t
    - report worker should be there and logging
- go to app-name
    - make the method get called

### Sidetiq
- add the sidetiq gem and bundle
- add configuration
