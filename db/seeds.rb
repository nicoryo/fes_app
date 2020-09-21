User.create!(
  [
    {
      email: 'ryoga@example.co.jp',
      name: 'Ryoga',
      sex: '0',
      birthday: '1991-08-31',
      password:  "password",
      password_confirmation: "password",
      introduction: "So long Boy"
    },
    {
      email: 'ayaka@example.co.jp',
      name: 'Ayaka',
      sex: '1',
      birthday: '1991-05-28',
      password:  "password",
      password_confirmation: "password",
      introduction: "Super Woman"
    }
  ]
)

Artist.create!(
  [
    {
      name: 'Bump of checken',
      icon: open("./db/fixtures/bump_of_chicken.jpeg")
    },
    {
      name: 'Radwimps',
      icon: open("./db/fixtures/radwimps.jpeg")
    }
  ]
)

# 9.times do |n|
#   User.create!(
#     email: "test#{n + 1}@example.com",
#     name: "テスト太郎#{n + 1}",
#     sex:  '1',
#     birthday: "196#{n +1}-0#{n +1}-0#{n +1}",
#     hashbody: "#5#{n +1}",
#     password:  "password",
#     password_confirmation: "password"
#   )

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
