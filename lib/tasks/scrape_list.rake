namespace :scrape_family do 

  desc "Scrape Info from Family List"
  task :get_names => :environment do
    # require 'open-uri'
    require 'csv'   

    csv_text = File.read('lib/tasks/list2.csv')
    csv = CSV.parse(csv_text, :headers => true)

    csv.each_with_index do |row, index|
      # if index < 10

      # puts row.to_hash['birth_day']
      # puts "#{row.to_hash['birth_day']} 12:0:00.000000000 Z"
        user = User.new()
        user.username               = row.to_hash['username']
        user.email                  = row.to_hash['email']                || "#{user.username}@exemple.com"
        user.first_name             = row.to_hash['first_name']           unless !row.to_hash['first_name']
        user.last_name              = row.to_hash['last_name']            unless !row.to_hash['last_name']
        user.maiden_name            = row.to_hash['maiden_name']          unless !row.to_hash['maiden_name']
        user.birth_day              = row.to_hash['birth_day']            unless !row.to_hash['birth_day']
        # user.birth_day              = "#{row.to_hash['birth_day']} 12:0:00.000000000 Z"            unless !row.to_hash['birth_day']
        user.birth_location         = row.to_hash['birth_location']       unless !row.to_hash['birth_location']
        user.death_day              = row.to_hash['death_day']            unless !row.to_hash['death_day']
        # user.death_day              = "#{row.to_hash['death_day']} 12:0:00.000000000 Z"            unless !row.to_hash['death_day']
        user.death_location         = row.to_hash['death_location']       unless !row.to_hash['death_location']
        # user.is_deceased            = if (user.death_day == "") then false else true end
        user.wedding_day            = row.to_hash['wedding_day']          unless !row.to_hash['wedding_day']
        # user.wedding_day            = "#{row.to_hash['wedding_day']} 12:0:00.000000000 Z"          unless !row.to_hash['wedding_day']
        user.wedding_location       = row.to_hash['wedding_location']     unless !row.to_hash['wedding_location']
        user.address_line1          = row.to_hash['address_line1']        unless !row.to_hash['address_line1']
        user.address_post_code      = row.to_hash['address_post_code']    unless !row.to_hash['address_post_code']
        user.address_city           = row.to_hash['address_city']         unless !row.to_hash['address_city']
        user.address_country        = row.to_hash['address_country']      unless !row.to_hash['address_country']
        user.secondary_email        = row.to_hash['secondary_email']      unless !row.to_hash['secondary_email']
        user.telephone              = row.to_hash['telephone']            unless !row.to_hash['telephone']
        user.secondary_telephone    = row.to_hash['secondary_telephone']  unless !row.to_hash['secondary_telephone']
        user.password               = 'LD2015'
        user.password_confirmation  = 'LD2015'

        if  user.save
          puts "#{index} - #{user.username} -- OK"
        else
          puts "#{index} - #{user.username} -- FAILED!"
        end

      # end
    end



    # url = "lib/tasks/list.csv"

    # url_data = open(url)

    # csv_text = File.read('lib/tasks/list1.csv')
    # csv_text = File.open("lib/tasks/list.csv", "r:ISO-8859-1")
    # csv = CSV.parse(csv_text, :headers => true)

    # puts csv_text

    # csv.each do |row|
    #   puts ">>>>>>>> #{row.to_hash}"
    #   # Language.create!(row.to_hash)
    # end

    # CSV.foreach( "lib/tasks/list1.csv", "r:windows-1250" ) do |row|
    #   puts row
    # end


    # puts url_data

    # CSV.foreach(csv_text) do |first_name, last_name|
      # puts "#{name}: #{symbol}" unless name == "Name"
      # puts "#{first_name} #{last_name}"
    #   # Company.create(:name => name, :symbol => symbol.squish, :stock_exchange => "NASDAQ") unless symbol == "Symbol"
    # end
    # puts "done scrapping"
  end

end