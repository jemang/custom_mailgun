env :PATH, ENV['PATH']
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/home/system/mailgun_user/log/cron.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
set :environment, :development
every 5.minute do
  runner "EventLog.import"
  runner "Event.import_daily"
  runner "Bounce.import"
end

every 1.day, at: '2:30 am' do
  runner "Event.import_monthly"
end
