# User.create!(name: "Michael Hartl", email: "mhartl@example.com", password_digest: 111111, password_confirmation: 111111)
# User.create(name: "Jon Hartl", email: "jhartl@example.com", password_digest: 111111, password_confirmation: 111111)
# User.create(name: "Jon1 Hartl", email: "j1hartl@example.com", password_digest: 111111, password_confirmation: 111111)
# User.create(name: "Jon2 Hartl", email: "j2hartl@example.com", password_digest: 111111, password_confirmation: 111111)
# User.create(name: "Jon3 Hartl", email: "j3hartl@example.com", password_digest: 111111, password_confirmation: 111111)
# User.create(name: "Jon4 Hartl", email: "j4hartl@example.com", password_digest: 111111, password_confirmation: 111111)
# User.create(name: "Jon5 Hartl", email: "j5hartl@example.com", password_digest: 111111, password_confirmation: 111111)

User.create!(name:  "Example User",
             email: "example0@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end