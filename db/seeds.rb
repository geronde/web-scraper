Museum.destroy_all

scrape = Scraper.new
museums = scrape.scrape_cities
Museum.create_ny_museums(museums)
