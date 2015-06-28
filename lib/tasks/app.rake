#encoding: utf-8
require 'csv'
namespace :app do

  desc 'set group leader'
  task :set_leader => :environment do
    users = User.where(:name => ['andrew.caillard','ian.dai','jane.skilton', 'frankie.zhao', 'andreas.larsson', 'fongyee.walker', 'chace.peng'])
    users.each do |user|
      user.update_attribute(:role, 'leader')
    end
    users = User.where(:name => ['chen.qian', 'dave.brookes'])
    users.each do |user|
      user.update_attribute(:role, 'e_group')
    end
  end

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

    file = Rails.root.join('lib', 'tasks', 'data', '2015', 'Sheet1-表格 1.csv')
    csv = CSV.open(file, :headers => false)
    csv.each do |item|
      print("*" * 1)
      group_name, uuid = item[1].split('_') if item[1].present?
      region = item[2].split('>').delete_if {|i| i.blank? }.join('>') if item[2].present?
      grape = item[3]
      name_zh = item[4]
      name_en = item[0]
      vintage = item[7]
      sugar = item[9]
      wine_style = item[6]
      alcohol = item[8]
      wine = Refinery::Wines::Wine.find_or_create_by_name_en_and_vingate(name_en,
                                                                         vintage,
                                                                         name_zh: name_zh,
                                                                         region_en: region,
                                                                         grape_vairety: grape,
                                                                         sugar: sugar,
                                                                         uuid: uuid,
                                                                         wine_style: wine_style,
                                                                         alcohol: alcohol

      )

      puts "#{item[4]} #{item[3]}" unless wine.id

      group = Refinery::WineGroups::WineGroup.find_or_create_by_name(group_name)
      Refinery::WineGroups::WineGroupItem.find_or_create_by_wine_id_and_group_id(wine.id, group.id)

    end
  end

  # desc "Import Wine"
  # task :init_wine_group_item => :environment do
  #   ActiveRecord::Base.connection.execute("TRUNCATE refinery_wines")
  #   ActiveRecord::Base.connection.execute("TRUNCATE refinery_wine_groups")
  #   ActiveRecord::Base.connection.execute("TRUNCATE refinery_wine_groups_wine_group_items")
  #
  #   file = Rails.root.join('lib', 'tasks', 'data', 'for Weston V2.csv')
  #   csv = CSV.open(file, :headers => false)
  #   csv.each do |item|
  #     next unless item[0].present?
  #     # group_name, uuid = item[1].split('_') if item[1].present?
  #      group_name = item[0].split('_').join('_')
  #      uuid = item[0] + item[1]
  #     name_zh = item[2]
  #     name_en = item[3]
  #     wine_style = item[4]
  #     region = item[5]
  #     vintage = item[6]
  #     alcohol = item[7]
  #      sugar = item[8]
  #      final_grape = []
  #      grape = item[10].split(";").uniq.delete_if{|i| i == '>'} if item[10].present?
  #      grape.each do |item|
  #        key, value = item.split('>')
  #        if !value.blank? && !key.blank?
  #          if (/%/ =~ value) == 0
  #            value = value
  #          elsif value.to_f < 1
  #            value = "#{value.to_f * 100.00}%"
  #          elsif value.to_f == 1 || value.to_f == 100
  #            value = '100%'
  #          else
  #            value = nil
  #          end
  #        else
  #          value = nil
  #        end
  #        final_grape << [key, value].compact.join(' ')
  #       # final_grape << item.split('>').uniq.compact.join(' ')
  #      end if grape.present?
  #     # region = item[2].split('>').delete_if {|i| i.blank? }.join('>') if item[2].present?
  #     wine = Refinery::Wines::Wine.find_or_create_by_name_en_and_vingate(name_en,
  #                                                                        vintage,
  #                                                                        name_zh: name_zh,
  #                                                                        region_en: region,
  #                                                                        grape_vairety: final_grape.join('; '),
  #                                                                        sugar: sugar,
  #                                                                        uuid: uuid,
  #                                                                        wine_style: wine_style,
  #                                                                        alcohol: alcohol
  #
  #     )
  #
  #     puts "#{item[4]} #{item[3]}" unless wine.id
  #
  #     group = Refinery::WineGroups::WineGroup.find_or_create_by_name(group_name)
  #     Refinery::WineGroups::WineGroupItem.find_or_create_by_wine_id_and_group_id(wine.id, group.id)
  #
  #   end
  # end

end
