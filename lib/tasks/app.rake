#encoding: utf-8
require 'csv'
namespace :app do
  desc "Import wine group"
  task :create_wine_group => :environment do
    ['新西兰长相思-Table 1.csv', '波尔多赤霞珠-Table 1.csv'].each do |filename|
      file =  Rails.root.join('lib', 'tasks', 'data', 'test', filename)
      csv  = CSV.open(file, :headers => true)
      csv.each do |item|
        wine = Refinery::Wines::Wine.find_or_create_by_name_en_and_vingate(item[1],
                                                                           item[5],
                                                                           name_zh: item[2],
                                                                           region_en: item[3],
                                                                           grape_vairety: item[4],
                                                                           sugar: item[6],
                                                                           uuid: item[0]
        )
        group = Refinery::WineGroups::WineGroup.find_or_create_by_name(filename.split('-').try(:first))
        Refinery::WineGroups::WineGroupItem.find_or_create_by_wine_id_and_group_id(wine.id, group.id)

      end
    end
  end

  desc "Import Wine"
  task :init_wine_group_item => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE refinery_wines")
    ActiveRecord::Base.connection.execute("TRUNCATE refinery_wine_groups")
    ActiveRecord::Base.connection.execute("TRUNCATE refinery_wine_groups_wine_group_items")

    file = Rails.root.join('lib', 'tasks', 'data', 'for Weston.csv')
    csv = CSV.open(file, :headers => true)
    csv.each do |item|

      group_name, uuid = item[0].split('-')
      wine = Refinery::Wines::Wine.find_or_create_by_name_en_and_vingate(item[4],
                                                                         item[6],
                                                                         name_zh: item[3],
                                                                         region_en: item[1],
                                                                         grape_vairety: item[2],
                                                                         sugar: item[7],
                                                                         uuid: uuid,
                                                                         wine_style: item[5]
      )

      puts "#{item[4]} #{item[3]}" unless wine.id

      group = Refinery::WineGroups::WineGroup.find_or_create_by_name(group_name)
      Refinery::WineGroups::WineGroupItem.find_or_create_by_wine_id_and_group_id(wine.id, group.id)

    end
  end

end
