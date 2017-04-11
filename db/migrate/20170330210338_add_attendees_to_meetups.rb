class AddAttendeesToMeetups < ActiveRecord::Migration[5.0]
  def change
    change_table :meetups do |table|
      table.string :attendees
    end
  end
end
