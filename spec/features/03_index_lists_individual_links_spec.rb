require 'spec_helper'

feature "Main page lists each meetup as a link to its own page" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "#each listed meetup is a link" do
    new_meetup_a = Meetup.create!({
      user_uid: user.uid,
      name: "Red Sox vs Rays @ 7:05pm",
      location: "Fenway Park",
      description: "The 19-13 Red Sox take on the 2-29 Rays at Fenway.",
      date_created: Time.now,
      attendees: "1"
      })

    visit '/'
    sign_in_as user
    expect(page).to have_link('Red Sox vs Rays @ 7:05pm')
  end

  scenario "#individual meetup page lists its information" do
    new_meetup_b = Meetup.create!({
      user_uid: user.uid,
      name: "Boston Calling",
      location: "Harvard Athletic Complex",
      description: "The weekend of May 26-28, feauting some very good bands and some very bad bands.",
      date_created: Time.now,
      attendees: "1"
      })

    visit '/'
    sign_in_as user
    click_link("Boston Calling")
    expect(page).to have_content('Location:Harvard Athletic Complex') # no space shown in test because location value is on new line
    expect(page).to have_content("The weekend of May 26-28, feauting some very good bands and some very bad bands.")
  end

end
