class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.date :date
      t.integer :delivered, default: 0
      t.integer :suppressed, default: 0
      t.integer :failed, default: 0
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
