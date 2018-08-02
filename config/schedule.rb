# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
every 5.minute do
  runner "EventLog.import", :environment => 'development'
  runner "Event.import_daily", :environment => 'development'
  runner "Event.import_monthly", :environment => 'development'
  runner "Bounce.import", :environment => 'development'
end
