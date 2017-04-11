class CreateMeetups < ActiveRecord::Migration[5.0]
  def change
    create_table :meetups do |table|
      table.integer :user_uid, null: false
      table.string :name, null: false
      table.string :location, null: false
      table.string :description, null: false

      table.timestamp :date_created
    end
  end
end
