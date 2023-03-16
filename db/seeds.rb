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
  name: "Life Club",
  address: '40 Rue du Docteur Escat, 13006 Marseille',
  logo: 'clubs/lifeclub.jpg'
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
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678912646/gym-buddy/maewenn_ihl6ed.jpg")
user.avatar.attach(io: file, filename: "maewenn.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Jean-Loup',
  email: 'jeanloup@lewagon.org',
  password: '123456',
  address: '24 Rue Haxo, 13001 Marseille',
  musculation_lvl: 3,
  cardio_lvl: 3,
  fitness_lvl: 1,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678912646/gym-buddy/jeanloup_hsxauy.jpg")
user.avatar.attach(io: file, filename: "jeanloup.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Anan',
  email: 'anan@lewagon.org',
  password: '123456',
  address: '26 Rue Haxo, 13001 Marseille',
  musculation_lvl: 3,
  cardio_lvl: 1,
  fitness_lvl: 2,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678912647/gym-buddy/anan_zzjkul.jpg")
user.avatar.attach(io: file, filename: "anan.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Théo',
  email: 'theo@lewagon.org',
  password: '123456',
  address: '30 Rue Haxo, 13001 Marseille',
  musculation_lvl: 3,
  cardio_lvl: 1,
  fitness_lvl: 1,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678912646/gym-buddy/theo_gvfblv.jpg")
user.avatar.attach(io: file, filename: "theo.png", content_type: "image/png")
user.save!

puts "OK!"

user = User.new(
  nickname: 'Damien',
  email: 'damien@lewagon.org',
  password: '123456',
  address: '30 Rue Haxo, 13001 Marseille',
  musculation_lvl: 3,
  cardio_lvl: 1,
  fitness_lvl: 3,
  locale: "fr"
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678912646/gym-buddy/damien_c706eu.jpg")
user.avatar.attach(io: file, filename: "damien.png", content_type: "image/png")
user.save!

puts "OK!"

print "Creating Events..."

DESCS = [
  "Viens dans mon event, y'aura des cookies.",
  "T'as vu comme je suis sexy ? Viens voir ça de plus près.",
  "Booooaaaaaaaargh ! *bande les muscles*.",
  "Viens, c'est comme coder du Ruby, mais avec de la sueur.",
  "Bienvenue, mes baby-sportifs !"
]

10.times do
  day = Date.today.day + rand(1..10)
  hour = rand(6..20)
  mins = [0, 30].sample
  event = Event.new(
    start_time: DateTime.new(2023, 3, day, hour, mins, 0),
    gym: Gym.all.sample,
    owner: User.all.sample,
    description: DESCS.sample,
    musculation: [true, false].sample,
    cardio: [true, false].sample,
    fitness: [true, false].sample,
    slots: rand(1..3)
  )
  event.musculation = true if !event.musculation && !event.cardio && !event.fitness
  event.fitness = false if event.musculation && event.cardio && event.fitness
  event.end_time = event.start_time + [1800, 3600].sample
  event.save!

  Chatroom.create!(
    event: event,
    name: "#{I18n.with_locale('fr') { I18n.l(event.start_time, format: '%d %B') }} de #{event.start_time.strftime('%Hh%M')} à #{event.end_time.strftime('%Hh%M')}"
  )
end

custom_day = Date.today.day
custom_hour = 18
custom_mins = 0
custom_event = Event.new(
  start_time: DateTime.new(2023, 3, custom_day, custom_hour, custom_mins, 0),
  gym_id: 1,
  owner_id: 1,
  description: "Manque un gros costaud pour un entraînement avec les copaings du Wagon !",
  musculation: true,
  cardio: false,
  fitness: false,
  slots: 3
)
custom_event.end_time = event.start_time + 3600
custom_event.save!

Chatroom.create!(
  event: custom_event,
  name: "#{I18n.with_locale('fr') { I18n.l(event.start_time, format: '%d %B') }} - #{event.start_time.strftime('%Hh%M')} à #{event.end_time.strftime('%Hh%M')}"
)

puts "OK!"
