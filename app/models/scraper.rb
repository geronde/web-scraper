require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def define_doc(url)
    html = open(url)
    Nokogiri::HTML(html)
  end

  def scrape_cities
    doc = define_doc('http://www.museumsusa.org/museums/?k=1271400%2cState%3aNY%3bDirectoryID%3a200454')
    ny_cities = doc.css('#city .browseCategoryItem a')

    urls = []

    ny_cities.each do |city|
      urls << city.attribute('href').value
    end

    scrape_museums_by_city(urls)
  end

  def scrape_museums_by_city(urls)
    museums = []
    urls.each do |city_url|
      doc = define_doc("http://www.museumsusa.org#{city_url}")
      museums_all = doc.css('.itemGroup .item')
      museums_all.each do |m|
        details = { state: m.css('.location').text.split(',')[1],
                    city: m.css('.location').text.split(',')[0],
                    name: m.css('.source').css('a').text,
                    categories: m.css('.type').text,
                    description: m.css('.abstract').text }
        museums << details
      end
    end
    museums
  end
end
