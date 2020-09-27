require 'nokogiri'
require 'open-uri'
require 'pry'

# Scraper class
class Scraper
  def define_doc(url)
    html = URI.open(url)
    Nokogiri::HTML(html)
  end

  def scrape_cities
    doc = define_doc('http://www.museumsusa.org/museums/?k=1271400%2cState%3aNY%3bDirectoryID%3a200454')
    ny_cities = doc.css('#city .browseCategoryItem a')

    puts ny_cities

    urls = []

    ny_cities.each do |city|
      urls << city.attribute('href').value
    end

    scrape_museums_by_city(urls)
  end

  def format_museum(museum)
    { state: museum.css('.location').text.split(',')[1],
      city: museum.css('.location').text.split(',')[0],
      name: museum.css('.source').css('a').text,
      categories: museum.css('.type').text,
      description: museum.css('.abstract').text }
  end

  def scrape_museums_by_city(urls)
    museums = []
    urls.each do |city_url|
      doc = define_doc("http://www.museumsusa.org#{city_url}")
      museums_all = doc.css('.itemGroup .item')
      
      museums_all.each do |m|
        details = format_museum(m)
        museums << details
      end
    end
    museums
  end
end
