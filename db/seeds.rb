# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
  # Example:
  # Person.create(first_name: 'Eric', last_name: 'Kelly')

User.create(provider: "github",uid: "78562301", username: "Nigel Kenny", email: "nk999889@gmail.com", avatar_url: "http://content.sportslogos.net/logos/40/2549/full/k0g2zypm2rrhmh4xh8gdjg77g.gif") 
User.create(provider: "github",uid: "77756621", username: "Teddy Roosevelt", email: "tr26@whitehouse.gov", avatar_url: "http://content.sportslogos.net/logos/40/1435/full/6097_frisco_roughriders-cap-2015.png")
User.create(provider: "github",uid: "24633313", username: "Helga Douglas", email: "helga8192@comcast.net", avatar_url: "http://content.sportslogos.net/logos/40/1446/full/6675.gif")

Meetup.create(user_uid: 24633313, name: "Big Pig Party", location: "Kenny's House, 13 Canal Street, Providence", description: "The pig roast for all ages!", date_created: Time.now, attendees: "24633313,78562301,77756621")
Meetup.create(user_uid: 24633313, name: "Red Sox Opening Day", location: "Fenway Park", description: "The Red Sox 2017 season kicks off on April 3 at 3pm at Fenway.", date_created: Time.now, attendees: "77756621")
Meetup.create(user_uid: 24633313, name: "Helga's 4th of July Parade", location: "Main Street, Wrentham", description: "It's July 4th and we are celebrating our independence from Great Britain!", date_created: Time.now, attendees: "78562301")
