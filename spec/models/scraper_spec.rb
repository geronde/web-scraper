require 'rails_helper'

RSpec.describe Scraper, type: :model do
  describe 'define' do
    it 'should open html of an url' do
      allow(URI).to receive(:open).and_return('ok')
      allow(Nokogiri).to receive(:HTML).and_return('html file')

      scraper = Scraper.new

      expect(URI).to receive(:open).with('https://fake-url')
      expect(Nokogiri).to receive(:HTML).with('ok')
      scraper.define_doc('https://fake-url')
    end
  end

  describe 'scrape_cities' do
    it 'should get urls via css query and call scrape_museums_by_city' do
      scraper = Scraper.new

      allow(scraper).to receive(:define_doc)
      allow(scraper.define_doc('fake-url')).to receive(:css).and_return([])

      allow(scraper).to receive(:scrape_museums_by_city).and_return(['list of museums'])

      expect(scraper).to receive(:define_doc).with('http://www.museumsusa.org/museums/?k=1271400%2cState%3aNY%3bDirectoryID%3a200454')
      expect(scraper).to receive(:scrape_museums_by_city).with([])
      scraper.scrape_cities
    end
  end

  describe 'format_museum' do
    it 'should return museum details' do
      scraper = Scraper.new

      html = '<div><div class="location">fake-city, fake-state</div> <div class="source"><a>source</a></div>
      <div class="type">type</div>
      <div class="abstract">fake-description</div>
      </div>'

      input = Nokogiri::HTML(html)

      expect(scraper.format_museum(input)).to include({
                                                        categories: 'type',
                                                        city: 'fake-city',
                                                        description: 'fake-description',
                                                        name: 'source',
                                                        state: ' fake-state'
                                                      })
    end
  end

  describe 'scrape_museums_by_city' do
    it 'should call define_doc and format_museum' do
      scraper = Scraper.new

      html = '<div><div class="location">fake-city, fake-state</div> <div class="source"><a>source</a></div>
      <div class="type">type</div>
      <div class="abstract">fake-description</div>
      </div>'

      input = Nokogiri::HTML(html)

      allow(scraper).to receive(:define_doc)
      allow(scraper.define_doc('fake-url')).to receive(:css).and_return([input])
      allow(scraper).to receive(:format_museum).and_return({ name: 'name' })

      expect(scraper).to receive(:define_doc).exactly(2)
      expect(scraper).to receive(:format_museum).exactly(2)

      expect(scraper.scrape_museums_by_city(%w[fake-url-1 fake-url-2])).to eql([{
                                                                                 name: 'name'
                                                                               },
                                                                                {
                                                                                  name: 'name'
                                                                                }])
    end
  end
end
