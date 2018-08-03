class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.mailgun
    @domain = Setting.last.try(:domain)
    @mg_client = Mailgun::Client.new(Setting.last.try(:api_key))
  end
end
