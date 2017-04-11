require 'spec_helper'

def create_test_data # was having issues with let, so I created this method
  user_b = User.create!({
    provider: "github",
    uid: "2",
    username: "jarlax2",
    email: "jarlax2@launchacademy.com",
    avatar_url: "http://www.gannett-cdn.com/experiments/usatoday/2015/12/star-wars-avatars/img/r2d2.png"
  })

  user_c = User.create!({
    provider: "github",
    uid: "3",
    username: "jarlax3",
    email: "jarlax3@launchacademy.com",
    avatar_url: "http://www.gannett-cdn.com/experiments/usatoday/2015/12/star-wars-avatars/img/c3p0.png"
  })

  user_d = User.create!({
    provider: "github",
    uid: "4",
    username: "jarlax4",
    email: "jarlax4@launchacademy.com",
    avatar_url: "http://www.gannett-cdn.com/experiments/usatoday/2015/12/star-wars-avatars/img/bb8.png"
  })

  big_pig_party = Meetup.create!({
    user_uid: user_a.uid,
    name: "Jerry\'s Big Pig Party",
    location: "123 Fake Street, Faketown, USA",
    description: "It's that time of year again; time to grab a spit, some fire, and roast a pig!",
    date_created: Time.now,
    attendees: "1,2,3,4"
  })
end

feature "Event page lists all users who are attending" do
  let(:user_a) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "list displays each attendee's name" do
    create_test_data
    visit '/'
    sign_in_as user_a

    click_on('Jerry\'s Big Pig Party')

    expect(page).to have_css("img[src*='https://avatars2.githubusercontent.com/u/174825?v=3&s=400']")
    expect(page).to have_css("img[src*='http://www.gannett-cdn.com/experiments/usatoday/2015/12/star-wars-avatars/img/r2d2.png']")
    expect(page).to have_css("img[src*='http://www.gannett-cdn.com/experiments/usatoday/2015/12/star-wars-avatars/img/c3p0.png']")
    expect(page).to have_css("img[src*='http://www.gannett-cdn.com/experiments/usatoday/2015/12/star-wars-avatars/img/bb8.png']")
  end

  scenario "list displays each attendee's avatar" do
    create_test_data
    visit '/'
    sign_in_as user_a

    click_on('Jerry\'s Big Pig Party')
    expect(page).to have_content("jarlax1 jarlax2 jarlax3 jarlax4")
  end
end
