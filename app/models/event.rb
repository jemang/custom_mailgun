class Event < ApplicationRecord
  # validates_uniqueness_of :date
  enum kind: [:daily, :month]

  def self.import_daily
    date = Date.today.to_time
    result = mailgun.get("#{@domain}/stats/total",
      {event: ['delivered', 'failed'], start: (date - 1.days).rfc2822, end: (date + 1.days).rfc2822}
    ) rescue nil

    unless result.nil?
      mail_data = JSON.parse(result.body)['stats']
      mail_data.each do |mail|
        record = Event.find_or_create_by(date: mail['time'].to_date, kind: 'daily')
        if record.persisted?
          record.delivered = mail['delivered']['total']
          record.suppressed = mail['failed']['permanent']['suppress-bounce']
          # delay = mail['failed']['permanent']['delayed-bounce'] rescue 0
          # bounce = mail['failed']['permanent']['bounce'] rescue 0
          record.failed = mail['failed']['permanent']['delayed-bounce'] + mail['failed']['permanent']['bounce']
          record.save
        end
      end
    else
      puts "wrong domain or keys"
    end
  end

  def self.import_monthly
    sum_total = mailgun.get("#{@domain}/stats/total",
      {event: ['failed', 'delivered'], duration: '2m'}
    ) rescue nil

    unless sum_total.nil?
      total = JSON.parse(sum_total.body)['stats']
      total.each do |t|
        record = Event.find_or_create_by(date: t['time'].to_date, kind: "month")
        if record.persisted?
          record.delivered = t['delivered']['total']
          record.suppressed = t['failed']['permanent']['suppress-bounce']
          record.failed = t['failed']['permanent']['delayed-bounce'] + t['failed']['permanent']['bounce']
          record.save
        end
      end
    end
  end
  
end
