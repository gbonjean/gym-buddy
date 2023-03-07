require 'faker'
Event.delete_all
Gym.delete_all

User.delete_all

print "Create gyms..."
Gym.create!(
  name: 'Basic Fit',
  address: '19 rue Saint-Ferréol Marseille',
  franchise: 'Basic Fit'
)
Gym.create!(
  name: 'Body Hit',
  address: '20 rue Haxo Marseille'
)
Gym.create!(
  name: "Fit N' Move",
  address: '54 rue de Rome Marseille'
)
Gym.create!(
  name: "Fitness Club 53",
  address: '53 rue Grignan Marseille'
)
Gym.create!(
  name: "KeepCool Marseille vieux port",
  address: '87 rue Sainte Marseille'
)
Gym.create!(
  name: "Fitness Park Bourse",
  address: '17 cours Belsunce Marseille'
)
puts "OK!"

print "Create Users..."
User.create!(
  nickname: 'titi',
  email: 'user1@gmail.com',
  password: '123456',
  address: '20 rue Haxo Marseille',
  musculation_lvl: rand(0..3),
  cardio_lvl: rand(0..3),
  fitness_lvl: rand(0..3),
  avatar_url: 'https://images.unsplash.com/photo-1667147381300-bcfa93fc6a87?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
)

User.create!(
  nickname: 'toto',
  email: 'user2@gmail.com',
  password: '123456',
  address: '20 rue Haxo Marseille',
  musculation_lvl: rand(0..3),
  cardio_lvl: rand(0..3),
  fitness_lvl: rand(0..3),
  avatar_url: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmVtbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60'
)

User.create!(
  nickname: 'tutu',
  email: 'user3@gmail.com',
  password: '123456',
  address: '20 rue Haxo Marseille',
  musculation_lvl: rand(0..3),
  cardio_lvl: rand(0..3),
  fitness_lvl: rand(0..3),
  avatar_url: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG9tbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60'
)
puts "OK!"

print "Create Events..."
5.times {
  event = Event.new(
    start_time: Date.today + rand(1..10),
    gym: Gym.all.sample,
    user: User.all.sample,
    description: Faker::Lorem.sentences,
    same_level: [true, false].sample,
    musculation: [true, false].sample,
    cardio: [true, false].sample,
    fitness: [true, false].sample
  )
  event.end_time = event.start_time + 1
  event.save!
}
puts "OK!"
