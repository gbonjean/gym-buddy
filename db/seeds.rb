require 'faker'
Event.delete_all
Gym.delete_all

User.delete_all

print "Create gyms..."
Gym.create!(
  name: 'Basic Fit',
  address: '19 rue Saint-Ferréol Marseille',
  franchise: 'Basic Fit',
  logo: 'clubs/BasicFit.png'
)
Gym.create!(
  name: 'Body Hit',
  address: '20 rue Haxo Marseille',
  logo: 'clubs/BodyHit.png'
)
Gym.create!(
  name: "Fit N' Move",
  address: '54 rue de Rome Marseille',
  logo: 'clubs/FitnMove.jpg'
)
Gym.create!(
  name: "KeepCool Marseille vieux port",
  address: '87 rue Sainte Marseille',
  logo: 'clubs/KeepCool.jpg'
)
Gym.create!(
  name: "Fitness Park Bourse",
  address: '17 cours Belsunce Marseille',
  logo: 'clubs/FitnessPark.jpg'
)
puts "OK!"

print "Create Users..."
user = User.new(
  nickname: 'Guillaume',
  email: 'guillaume@gmail.com',
  password: '123456',
  address: '20 rue Haxo Marseille',
  musculation_lvl: rand(0..3),
  cardio_lvl: rand(0..3),
  fitness_lvl: rand(0..3)
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271189/gym-buddy/user1_gbzrq2.jpg")
user.avatar.attach(io: file, filename: "guillaume.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Paulin',
  email: 'paulin@gmail.com',
  password: '123456',
  address: '20 rue Haxo Marseille',
  musculation_lvl: rand(0..3),
  cardio_lvl: rand(0..3),
  fitness_lvl: rand(0..3)
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271190/gym-buddy/user3_ftmicb.jpg")
user.avatar.attach(io: file, filename: "paulin.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Jérôme',
  email: 'jerome@gmail.com',
  password: '123456',
  address: '20 rue Haxo Marseille',
  musculation_lvl: rand(0..3),
  cardio_lvl: rand(0..3),
  fitness_lvl: rand(0..3)
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271190/gym-buddy/user2_wuxonh.jpg")
user.avatar.attach(io: file, filename: "jerome.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Marie-Chantal',
  email: 'mariechantal@gmail.com',
  password: '123456',
  address: '20 rue Haxo Marseille',
  musculation_lvl: rand(0..3),
  cardio_lvl: rand(0..3),
  fitness_lvl: rand(0..3)
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271190/gym-buddy/user4_rbnpdu.jpg")
user.avatar.attach(io: file, filename: "mc.png", content_type: "image/png")
user.save!

user = User.new(
  nickname: 'Le Chien',
  email: 'lechien@gmail.com',
  password: '123456',
  address: '20 rue Haxo Marseille',
  musculation_lvl: rand(0..3),
  cardio_lvl: rand(0..3),
  fitness_lvl: rand(0..3)
)
file = URI.open("https://res.cloudinary.com/dx1sso7tq/image/upload/v1678271190/gym-buddy/user5_fidg0w.jpg")
user.avatar.attach(io: file, filename: "chien.png", content_type: "image/png")
user.save!

puts "OK!"

print "Create Events..."
20.times {
  day = Date.today.day + rand(1..10)
  hour = rand(6..20)
  mins = [0, 30].sample
  event = Event.new(
    start_time: DateTime.new(2023, 3, day, hour, mins, 0),
    gym: Gym.all.sample,
    owner: User.all.sample,
    description: Faker::Lorem.sentences,
    same_level: [true, false].sample,
    musculation: [true, false].sample,
    cardio: [true, false].sample,
    fitness: [true, false].sample,
    slots: rand(1..3)
  )
  event.end_time = event.start_time + [1800, 3600].sample
  event.save!
}
puts "OK!"
