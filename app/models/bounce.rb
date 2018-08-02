class Bounce < ApplicationRecord

  def self.import
    result = mailgun.get("#{@domain}/bounces",
      {:limit => 50}
    ) rescue nil
    
    unless result.nil?
      data = JSON.parse(result.body)['items']
      data.each do |user|
        record = Bounce.find_or_create_by(date: user['created_at'].to_date, email: user['address'])
        if record.persisted?
          record.status = user['error']
          record.save
        end
      end
    else
      puts "wrong keys or domain"
    end
  end
  
end
