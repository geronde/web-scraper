Museum.destroy_all

scrape = Scraper.new
puts 'seeds start'
museums = scrape.scrape_cities
Museum.create_ny_museums(museums)
