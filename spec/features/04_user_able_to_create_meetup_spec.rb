require 'spec_helper'

feature "Page exists to create meetup & add it to database" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "Link exists on main page for creating meetup" do
    visit '/'
    sign_in_as user

    expect(page).to have_link('Create new Meetup')
  end

  scenario "User cannot create a meetup if they are not signed in" do
    visit '/'
    click_on('Create new Meetup')
    expect(page).to have_content('You must be signed in to create a meetup.')
  end

  scenario "signed in user provides all info to successfully create meetup & sees meetup page" do
    visit '/'
    sign_in_as user
    visit '/meetups/new'

    fill_in("name", :with => 'Game of Thrones: Season Premiere Watch Party')
    fill_in('location', :with => 'Rachel\'s apartment, 45 Canal St, Providence, RI')
    fill_in('description', :with => 'Season 7 returns on July 16, and everyone who\'s anyone will be gathering to watch the premiere! Please bring chips.')
    click_on('Add Meetup')

    expect(page).to have_content('Meetup created!')
    expect(page).to have_content("Game of Thrones: Season Premiere Watch Party")
    expect(page).to have_content('Creator:jarlax1')
    expect(page).to have_content('Location:Rachel\'s apartment, 45 Canal St, Providence, RI')
  end

  scenario "error messages displayed if meetup creation is unsucessful" do
    visit '/'
    sign_in_as user
    visit '/meetups/new'

    fill_in('location', :with => 'Helms Deep')
    fill_in('description', :with => 'Saruman marches to Helms Deep with an army bred for a single purpose: to destroy the world of men.')
    click_on('Add Meetup')

    expect(page).to have_content('Please completely fill out each field.')
  end

  scenario "entered data persists in input if meetup creation was unsucessful" do
    visit '/'
    sign_in_as user
    visit '/meetups/new'

    fill_in('location', :with => 'Bubba\`s Crab Shack')
    expect(page).to have_field('Location', :with => 'Bubba\`s Crab Shack')
  end
end
