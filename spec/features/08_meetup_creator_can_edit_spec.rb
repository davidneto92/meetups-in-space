require 'spec_helper'

feature "Meetup creator can edit even details" do
  let(:user_a) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let(:user_b) do
    User.create(
    provider: "github",
    uid: "2",
    username: "jarlax2",
    email: "jarlax2@launchacademy.com",
    avatar_url: "http://www.gannett-cdn.com/experiments/usatoday/2015/12/star-wars-avatars/img/r2d2.png"
  )
  end

  scenario "button exists on meetup page for meetup creator" do
    new_meetup_a = Meetup.create!({
      user_uid: user_a.uid,
      name: "Jerry\'s Big Pig Party",
      location: "123 Fake Street, Faketown, USA",
      description: "It's that time of year again; time to grab a spit, some fire, and roast a pig!",
      date_created: Time.now,
      attendees: "1"
    })

    visit '/'
    sign_in_as user_a
    click_link("Jerry\'s Big Pig Party")

    expect(page).to have_button('EditMeetup')
  end

  scenario "button does not appear for user that did not create meetup" do
    new_meetup_b = Meetup.create!({
      user_uid: user_b.uid,
      name: "Butcher Shop Sale",
      location: "14 Main Street, Louisville, KY",
      description: "CHEAP CHEAP MEATS!",
      date_created: Time.now,
      attendees: "2"
    })

    visit '/'
    sign_in_as user_a
    click_link("Butcher Shop Sale")

    expect(page).not_to have_button('EditMeetup')
  end

  pending "clicking button brings user to edit page with pre-filled forms"
  pending "submitting all valid data allows user to change event details and notifies user of success"
  pending "failing to complete all forms will notify user that change has failed"

end
