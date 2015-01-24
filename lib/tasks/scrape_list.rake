namespace :scrape_family do 

  desc "Scrape Info from Family List"
  task :get_names => :environment do
    require 'open-uri'
    require 'csv'

    url = "https://s3.amazonaws.com/famille-ld/list.csv"

    url_data = open(url)

    csv = CSV.parse(url_data, :headers => true)

    csv.each_with_index do |row, index|
        user = User.new()
        user.username               = row.to_hash['username'].force_encoding("utf-8")
        user.email                  = row.to_hash['email']              || "#{user.username}@exemple.com"
        user.first_name             = row.to_hash['first_name'].force_encoding("utf-8")           unless !row.to_hash['first_name']
        user.last_name              = row.to_hash['last_name'].force_encoding("utf-8")            unless !row.to_hash['last_name']
        user.maiden_name            = row.to_hash['maiden_name'].force_encoding("utf-8")          unless !row.to_hash['maiden_name']
        user.birth_day              = row.to_hash['birth_day'].force_encoding("utf-8")            unless !row.to_hash['birth_day']
        user.birth_location         = row.to_hash['birth_location'].force_encoding("utf-8")       unless !row.to_hash['birth_location']
        user.death_day              = row.to_hash['death_day'].force_encoding("utf-8")            unless !row.to_hash['death_day']
        user.death_location         = row.to_hash['death_location'].force_encoding("utf-8")       unless !row.to_hash['death_location']
        user.is_deceased            = true if user.death_day
        user.wedding_day            = row.to_hash['wedding_day'].force_encoding("utf-8")          unless !row.to_hash['wedding_day']
        user.wedding_location       = row.to_hash['wedding_location'].force_encoding("utf-8")     unless !row.to_hash['wedding_location']
        user.is_married             = true if user.wedding_day
        user.address_line1          = row.to_hash['address_line1'].force_encoding("utf-8")        unless !row.to_hash['address_line1']
        user.address_post_code      = row.to_hash['address_post_code'].force_encoding("utf-8")    unless !row.to_hash['address_post_code']
        user.address_city           = row.to_hash['address_city'].force_encoding("utf-8")         unless !row.to_hash['address_city']
        user.address_country        = row.to_hash['address_country'].force_encoding("utf-8")      unless !row.to_hash['address_country']
        user.secondary_email        = row.to_hash['secondary_email'].force_encoding("utf-8")      unless !row.to_hash['secondary_email']
        user.telephone              = row.to_hash['telephone'].force_encoding("utf-8")            unless !row.to_hash['telephone']
        user.secondary_telephone    = row.to_hash['secondary_telephone'].force_encoding("utf-8")  unless !row.to_hash['secondary_telephone']
        user.password               = 'LD2015'
        user.password_confirmation  = 'LD2015'

        if  user.save
          puts "#{index} - #{user.username} -- OK"
        else
          puts "#{index} - #{user.username} -- FAILED!"
        end
    end
    puts "done scrapping"
  end
end