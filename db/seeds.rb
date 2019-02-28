# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lastsacred = User.create(name: "LastSacred", battletag: "LastSacred#1265", replay_path: "./test/replays/", auto_roster: false)

Match.import(lastsacred.replay_path)

hero_names = [
  "Lúcio",
  "Probius",
  "Sonya",
  "Artanis",
  "Kharazim",
  "Zul'jin",
  "Stitches",
  "Diablo",
  "Samuro",
  "Kael'thas",
  "Mal'Ganis",
  "Varian",
  "Greymane",
  "Li Li",
  "Tracer",
  "Azmodan"
]

heroes = hero_names.collect do |hero_name|
  Hero.find_by(name: hero_name)
end

lastsacred.update(heroes: heroes)
