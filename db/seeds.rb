require 'faker'

Event.delete_all
Gym.delete_all
User.delete_all
Chatroom.delete_all
Notification.delete_all

print "Creating Gyms..."
Gym.create!(
  name: 'Basic Fit Saint-Ferréol',
  address: '19 Rue Saint-Ferréol Marseille',
  franchise: 'Basic Fit',
  logo: 'clubs/BasicFit.png'
)
Gym.create!(
  name: "So Good Campus",
  address: '116 Avenue Jules Cantini, 13008 Marseille',
  logo: 'clubs/sogood.png'
)
Gym.create!(
  name: "KeepCool Vieux port",
  address: '87 Rue Sainte, 13007 Marseille',
  logo: 'clubs/KeepCool.jpg'
)
Gym.create!(
  name: "Fitness Park Bourse",
  address: '17 Cours Belsunce, 13001 Marseille',
  logo: 'clubs/FitnessPark.jpg'
)
Gym.create!(
  name: "Keepcool Castellane",
  address: '172 Rue de Rome, 13006 Marseille',
  logo: 'clubs/KeepCool.jpg'
)
Gym.create!(
  name: "L'Orange Bleue Longchamp",
  address: '117 Boulevard Camille Flammarion, 13004 Marseille',
  logo: 'clubs/orangebleue.png'
)
Gym.create!(
  name: "Life Club",
  address: '40 Rue du Docteur Escat, 13006 Marseille',
  logo: 'clubs/lifeclub.jpg'
)
Gym.create!(
  name: "Wellness Sport Club Prado",
  address: '330 Avenue du Prado, 13008 Marseille',
  logo: 'clubs/wellness.png'
)
Gym.create!(
  name: "Fitness Park Terrasses du Port",
  address: '9 Quai du Lazaret, 13002 Marseille',
  logo: 'clubs/FitnessPark.jpg'
)
Gym.create!(
  name: 'Basic-Fit Quai de la Joliette',
  address: '4 Quai de la Joliette, 13002 Marseille',
  franchise: 'Basic Fit',
  logo: 'clubs/BasicFit.png'
)
puts "OK!"

print "Creating Users..."

user = User.new(
  nickname: 'Maewenn',
  email: 'maewenn@lewagon.org',
  password: '123456',
  address: '22 Rue Haxo, 13001 Marseille',
  musculation_lvl: 3,
  cardio_lvl: 1,
  fitness_lvl: 1,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271189/gym-buddy/user1_gbzrq2.jpg")
user.avatar.attach(io: file, filename: "maewenn.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Jean-Loup Le Skinch',
  email: 'jeanloup@lewagon.org',
  password: '123456',
  address: '24 Rue Haxo, 13001 Marseille',
  musculation_lvl: 1,
  cardio_lvl: 3,
  fitness_lvl: 1,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271189/gym-buddy/user1_gbzrq2.jpg")
user.avatar.attach(io: file, filename: "jeanloup.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Anan',
  email: 'anan@lewagon.org',
  password: '123456',
  address: '26 Rue Haxo, 13001 Marseille',
  musculation_lvl: 2,
  cardio_lvl: 1,
  fitness_lvl: 2,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271189/gym-buddy/user1_gbzrq2.jpg")
user.avatar.attach(io: file, filename: "anan.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Damien',
  email: 'damien@lewagon.org',
  password: '123456',
  address: '28 Rue Haxo, 13001 Marseille',
  musculation_lvl: 3,
  cardio_lvl: 2,
  fitness_lvl: 1,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271189/gym-buddy/user1_gbzrq2.jpg")
user.avatar.attach(io: file, filename: "damien.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Théo',
  email: 'theo@lewagon.org',
  password: '123456',
  address: '30 Rue Haxo, 13001 Marseille',
  musculation_lvl: 1,
  cardio_lvl: 1,
  fitness_lvl: 3,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271189/gym-buddy/user1_gbzrq2.jpg")
user.avatar.attach(io: file, filename: "theo.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Dylane',
  email: 'dylane@lewagon.org',
  password: '123456',
  address: '32 Rue Haxo, 13001 Marseille',
  musculation_lvl: 2,
  cardio_lvl: 2,
  fitness_lvl: 2,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271189/gym-buddy/user1_gbzrq2.jpg")
user.avatar.attach(io: file, filename: "dylane.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Jim',
  email: 'jim@lewagon.uk',
  password: '123456',
  address: '20 Rue Haxo, 13001 Marseille',
  musculation_lvl: 2,
  cardio_lvl: 1,
  fitness_lvl: 2,
  locale: "en"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271189/gym-buddy/user1_gbzrq2.jpg")
user.avatar.attach(io: file, filename: "jim.png", content_type: "image/png")
user.save!

puts "OK!"

print "Creating Events..."

30.times do
  day = Date.today.day + rand(1..10)
  hour = rand(6..20)
  mins = [0, 30].sample
  event = Event.new(
    start_time: DateTime.new(2023, 3, day, hour, mins, 0),
    gym: Gym.all.sample,
    owner: User.all.sample,
    description: Faker::ChuckNorris.fact,
    musculation: [true, false].sample,
    cardio: [true, false].sample,
    fitness: [true, false].sample,
    slots: rand(1..3)
  )
  event.musculation = true if !event.musculation && !event.cardio && !event.fitness
  event.end_time = event.start_time + [1800, 3600].sample
  event.save!
end

day = Date.today.day
hour = 18
mins = 30
event = Event.new(
  start_time: DateTime.new(2023, 3, day, hour, mins, 0),
  gym_id: 1,
  owner_id: 1,
  description: "Entraînement du Wagon, reste 1 place disponible",
  musculation: true,
  cardio: false,
  fitness: false,
  slots: 3
)
event.end_time = event.start_time + 3600
event.save!

Chatroom.create!(
  event: event,
  name: "#{ I18n.l(event.start_time, format: '%d %B') }} #{I18n.t 'events.from'} #{event.start_time.strftime('%Hh%M')} #{I18n.t 'events.to'} #{event.end_time.strftime('%Hh%M')}"
)
puts "OK!"
