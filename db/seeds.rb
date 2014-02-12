# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
  { name: 'admin',
    email: 'admin@example.com',
    password: '123456',
    password_confirmation: '123456',
    admin: true
  },
  { name: 'user',
    email: 'user@example.com',
    password: '123456',
    password_confirmation: '123456',
    admin: false 
  }
])

Project.create(name: "Ticketee Beta")

State.create([
  { name: "New",
    color: "white",
    background: "#85FF00"
  },
  { name: "Open",
    color: "white",
    background: "#00CFFD"
  },
  { name: "Closed",
    color: "white",
    background: "black"
  }
])
