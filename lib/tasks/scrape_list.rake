namespace :scrape_family do 

  desc "Scrape Info from Family List"
  task :get_names => :environment do
    # require 'open-uri'
    require 'csv'

    require 'csv'   

    csv_text = File.read('lib/tasks/list.csv')
    csv = CSV.parse(csv_text, :headers => true)

    csv.each_with_index do |row, index|
      # puts ">>>>>>>> #{row.to_hash}"
      if index < 6

        puts "#{index} #{row.to_hash['email']}"
        # User.create(:email => row.to_hash['email'] )
        user = User.new(:email => row.to_hash['email'], :password => 'LD2015', :password_confirmation => 'LD2015')
        if  user.save
          puts user
        else
          puts "no no"
        end

      end
      # Language.create!(row.to_hash)
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