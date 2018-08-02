class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.mailgun
    @domain = 'mx.fibrecomm.net.my'
    @mg_client = Mailgun::Client.new 'key-0x4xsgtm5frr2ow1pyr0jqlryl9v6k35'
  end
end
