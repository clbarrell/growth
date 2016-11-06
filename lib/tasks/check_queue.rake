namespace :check_queue do
  desc "Checks whether background_jobs.count > 0, spawns or kills workers as needed"
  task is_queue_empty: :environment do
    puts "START\nstarting check_queue rake"
    require 'platform-api'
    heroku = PlatformAPI.connect_oauth(ENV['HEROKU_API_KEY'])
    queue_count = Delayed::Job.count
    worker_count = heroku.dyno.list("growth-focus").select { |dyno| dyno["type"] == "worker" }.count
    puts "queue_count: #{queue_count}"
    puts "worker_count: #{worker_count}"
    if queue_count > 0 && worker_count == 0
      # add a worker
      heroku.formation.update("growth-focus", "worker", {"quantity"=>1})
      puts "adding worker"
    elsif queue_count == 0 && worker_count > 0
      # remove worker
      heroku.formation.update("growth-focus", "worker", {"quantity"=>0})
      puts "removing worker"
    end

  end

  # heroku.formation.update("growth-focus", "worker", {"quantity"=>0})
  # http://pete-hamilton.co.uk/2014/05/08/scale-heroku-by-time-of-day/
end
