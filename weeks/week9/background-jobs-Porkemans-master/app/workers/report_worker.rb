class ReportWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable
  sidekiq_options retry: false

  #Simple Jobs
  recurrence { hourly }
  # recurrence { weekly }

  #Complex recurrence
  # recurrence do
  #   monthly(2).day_of_week(1 => [1], 2 => [-1]).hour_of_day(12)
  # end

  def perform
    puts "SIDEKIQ IS DOING THE THING!"
    PokemonMailer.new_email.deliver_later
  end

end
