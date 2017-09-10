# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pixo_gem = Gem::Specification.find_by_name 'pixo'

patterns_dir = File.join(pixo_gem.gem_dir,'ext', 'pixo', 'patterns')

Dir.entries(patterns_dir).each do | pattern_file|
  next unless pattern_file.end_with? '.glsl'
  Pattern.where(name: pattern_file.split('.').first)
    .first_or_create!(code: File.read(File.join(patterns_dir, pattern_file)))
end
