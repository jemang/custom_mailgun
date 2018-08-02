class CreateEventLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :event_logs do |t|
      t.datetime :date
      t.string :status
      t.string :email_from
      t.string :email_to
      t.string :reason
      t.text :subject
      t.string :mailgun_id

      t.timestamps
    end
  end
end
