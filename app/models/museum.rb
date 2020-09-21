class Museum < ApplicationRecord
  def self.create_ny_museums(museums)
    museums.each do |m|
      puts m
      Museum.create(m)
    end
  end
end
