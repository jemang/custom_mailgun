json.set! :data do
  json.array!(@logs) do |log|
    json.date log.date.strftime('%m/%d/%Y at %H:%M:%S')
    # json.date log.date
    json.mailgun_id log.mailgun_id
    json.stat log.status
    json.email log.email_from
    json.user log.email_to
    json.reason log.reason
    json.subject log.subject
  end
end