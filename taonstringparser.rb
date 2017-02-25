# Include the Necessary Tools

require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'
require 'csv'

# Pull The Page Down

page = Nokogiri::HTML(RestClient.get("http://www.ndbc.noaa.gov/to_station.shtml")) do |config|
  config.strict.noblanks
end

# Put Bouy Numbers Into Data Structure
@bouys = Array.new
page.css('.result').each do |buoy|
  buoy_number = buoy.css("a[class=business-name]").each do |by|
end
end

@buoys << {:Name => by.content }

# display hash result
puts @buoys
