
require 'spec_helper'

feature "User sees name of each meetup as link" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "sees alphabetcal list of meetups" do
    new_meetup_a = Meetup.create!({
      user_uid: 24555565,
      name: "Jerry\'s Big Pig Party",
      location: "123 Fake Street, Faketown, USA",
      description: "It's that time of year again; time to grab a spit, some fire, and roast a pig!",
      date_created: Time.now,
      attendees: "1"
    })

    new_meetup_b = Meetup.create!({
      user_uid: user.uid,
      name: "Police Raid",
      location: "Speakeasy",
      description: "This is the police, open up!",
      date_created: Time.now,
      attendees: "1"
    })

    new_meetup_c = Meetup.create!({
      user_uid: user.uid,
      name: "Ricky\'s Dope Shop",
      location: "Sunnyvale Trailer Park",
      description: "Corey, Trevor; smokes, let\'s go.",
      date_created: Time.now,
      attendees: "1"
    })


    visit '/'
    sign_in_as user
    expect(page).to have_content('Ricky\'s Dope Shop')

    expect(page).to have_content('Jerry\'s Big Pig Party Police Raid')
  end
end
