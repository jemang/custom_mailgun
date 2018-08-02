class EventLog < ApplicationRecord
  validates_uniqueness_of :mailgun_id

  def self.import
    date = Date.today.to_time
    sections = %w[delivered opened failed]
    sections.each do |section|
      result = mailgun.get("#{@domain}/events",
        {event: section, begin: (date + 1.days).rfc2822, end: (date - 1.days).rfc2822, limit: 300}
      ) rescue nil
      
      unless result.nil?
        logs = JSON.parse(result.body)['items']
        
        logs.each do |event|
          puts event
          record = EventLog.find_by(mailgun_id: event['id'])
          if record.nil?
            EventLog.create(
              date: Time.at(event['timestamp']),
              mailgun_id: event['id'],
              status: event['event'],
              email_from: event['message']['headers']['from'],
              email_to: event['recipient'],
              reason: event['reason'],
              subject: event['message']['headers']['subject']
            )
          end
        end
      else
        puts "wrong api or domain"
      end
    end
  end

  def self.import_all
    sections = %w[delivered opened failed]
    date_start = Date.today - 35.days
    date_end = Date.today
    (date_start..date_end).each do |date|
      sections.each do |section|
        result = mailgun.get("#{@domain}/events",
          {event: section, begin: (date + 1.days).rfc2822, end: (date - 1.days).rfc2822, limit: 300}
        ) rescue nil
        
        unless result.nil?
          logs = JSON.parse(result.body)['items']
          
          logs.each do |event|
            record = EventLog.find_by(mailgun_id: event['id'])
            if record.nil?
              EventLog.create(
                date: Time.at(event['timestamp']),
                mailgun_id: event['id'],
                status: event['event'],
                email_from: event['message']['headers']['from'],
                email_to: event['recipient'],
                reason: event['reason'],
                subject: event['message']['headers']['subject']
              )
            end
          end
        else
          puts "wrong api or domain"
        end
      end
    end
  end
  
end
