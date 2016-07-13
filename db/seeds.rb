# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Item.create!(shop: "Item", name: "Potion", description: "Restores 10 HP", lvl: 1, rec_hp: 10, cost: 10)
Item.create!(shop: "Item", name: "Hi-Potion", description: "Restores 50 HP", lvl: 2, rec_hp: 50, cost: 50)
Item.create!(shop: "Item", name: "X-Potion", description: "Restores 200 HP", lvl: 3, rec_hp: 200, cost: 200)
Item.create!(shop: "Item", name: "Ether", description: "Restores 10 MP", lvl: 1, rec_mp: 10, cost: 10)
Item.create!(shop: "Item", name: "Turbo Ether", description: "Restores 50 MP", lvl: 2, rec_mp: 50, cost: 50)
Item.create!(shop: "Item", name: "Max Ether", description: "Restores 200 MP", lvl: 3, rec_mp: 200, cost: 200)
Item.create!(shop: "Item", name: "Elixir", description: "Restores 100 HP and MP", lvl: 3, rec_hp: 100, rec_mp: 100, cost: 250)
Item.create!(shop: "Equipment", name: "Beginner's Sword", description: "This sword holds the might of infinite possibilities, the starting point for every adventurer worthy of taking of the gratuitous task of battle. Lacks a reliable edge though.",
             str: 3, cost: 100, body_pt: "Weapon")
Item.create!(shop: "Equipment", name: "Beginner's Armor", description: "This armour is crafted from steel tempered with the shining dreams and burning souls of every would-be adventurer. An invaluable companion for your journey, though it won't survive three hits from a goblin.", 
            hp: 50, cost: 100, body_pt: "Body")

Mob.create!(name: "Goblin", description: "A goblin so common that there is no description for it.", hp: 100, att: 10, gold: 100, resource_pt: 20)

Town.create!(name: "Zeus")
Town.create!(name: "Odin")
Town.create!(name: "Thor")
Town.create!(name: "Ares")
Town.create!(name: "Neutral", item_lvl: 99, eqp_lvl: 99, castle_lvl: 99)

Job.create!(name: "Apprentice", str: 1.5)
Job.create!(name: "Warrior", str: 2.5, agi: 0.5, str_bonus: 2, agi_bonus: 1)
Job.create!(name: "Mage", int: 2.8, luck: 0.2, int_bonus: 3)
Job.create!(name: "Thief", agi: 2.5, vit: 0.5, agi_bonus: 2, vit_bonus: 1)
Job.create!(name: "Monk", str: 1.5, vit: 1.5, str_bonus: 2, vit_bonus: 1)
Job.create!(name: "Magic_Knight", str: 2, int: 2, str_bonus: 3, int_bonus: 3, hidden: true)
Job.create!(name: "Berserker", int: 1, vit: 3, vit_bonus: 4, int_bonus: 2, hidden: true)

User.create!(first_name:  "Administrator",
             last_name: "1",
             identity_no: "admin1",
             email: "admin1@roleplay.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             class_no: 0,
             year: 0,
             clan: "Neutral",
             title: "Administrator",
             gold_pts: 10000,
             resource_pts: 10000)

100.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  identity_no = "S" + Faker::PhoneNumber.subscriber_number(8).to_s + ('A'..'Z').to_a.sample
  email = "example-#{n+1}@roleplay.org"
  password = "password"
  class_no = n % 4 + 1
  clan_name = class_no == 1 ? "Zeus" : 
              class_no == 2 ? "Odin" :
              class_no == 3 ? "Thor" :
              class_no == 4 ? "Ares" :
              "Neutral"

  User.create!(first_name:  first_name,
               last_name: last_name,
               identity_no: identity_no,
               email: email,
               password:              password,
               password_confirmation: password,
               luck: rand(100),
               class_no: class_no,
               year: 2016,
               clan: clan_name)
end

100.times do |n|
  title = Faker::Lorem.sentence
  description = Faker::Lorem.paragraphs

  Message.create!(title: title,
                  description: description,
                  user_id: rand(99) + 1)
end

100.times do |n|
  content = Faker::Lorem.sentence

  Comment.create!(content: content,
                  message_id: rand(99) + 1,
                  user_id: rand(99) + 1)
end