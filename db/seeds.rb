# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

# Added by Refinery CMS Members extension
Refinery::Members::Engine.load_seed

# Added by Refinery CMS Wines extension
Refinery::Wines::Engine.load_seed

# Added by Refinery CMS Wine Groups extension
Refinery::WineGroups::Engine.load_seed

# Added by Refinery CMS Wine Group Items extension
Refinery::WineGroups::Engine.load_seed

# Added by Refinery CMS Items extension
Refinery::UserGroups::Engine.load_seed
