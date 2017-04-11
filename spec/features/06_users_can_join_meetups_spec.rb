require 'spec_helper'

def join_tests
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

  danish = Meetup.create!({
    user_uid: user_b.uid,
    name: "New York City Danish Festival",
    location: "34th Street Bakery",
    description: "If you eva wanted a caw'fee n' danish, this is the festival for you.",
    date_created: Time.now,
    attendees: "2,3,4"
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

  scenario "join button showing if user is not already attending" do
    join_tests
    visit '/'
    sign_in_as user_a

    click_on('New York City Danish Festival')
    expect(page).to have_button('JoinMeetup')
  end

  scenario "clicking button while signed in will flash that user has joined and add to list" do
    join_tests
    visit '/'
    sign_in_as user_a

    click_on('New York City Danish Festival')
    click_on('JoinMeetup')

    expect(page).to have_content('You have joined the meetup!')
    expect(page).to have_css("img[src*='https://avatars2.githubusercontent.com/u/174825?v=3&s=400']")
    expect(page).to have_content("jarlax2 jarlax3 jarlax4 jarlax1")
  end

  scenario "click join on a meetup that a user has already joined will not add them again" do
    join_tests
    visit '/'
    sign_in_as user_a

    click_on('New York City Danish Festival')
    click_on('JoinMeetup')
    click_on('JoinMeetup')

    expect(page).to have_content('You have already joined this meetup.')
  end

  scenario "clicking on button while not signed in will prompt user to sign in" do
    join_tests
    visit '/'
    click_on('New York City Danish Festival')
    click_on('JoinMeetup')

    expect(page).to have_content('You must sign in to join a meetup.')
  end

end
