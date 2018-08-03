class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :domain
      t.string :api_key
      t.string :ip_address
      t.string :smtp_hostname
      t.string :smtp_login
      t.string :api_url
      t.string :default_password

      t.timestamps
    end
  end
end
