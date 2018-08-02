class CreateBounces < ActiveRecord::Migration[5.2]
  def change
    create_table :bounces do |t|
      t.date :date
      t.string :email
      t.text :status

      t.timestamps
    end
  end
end
