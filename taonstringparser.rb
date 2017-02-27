# Include the Necessary Tools

require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'
require 'csv'
require 'pp'

# Pull The Page Down

page = Nokogiri::HTML(RestClient.get("http://www.ndbc.noaa.gov/to_station.shtml")) do |config|
  config.strict.noblanks
end

@bouy_blocks = Array.new
page.search('pre a').each do |block|
  # puts block.text
  id_hash = { :Bouyid => block.text }
  # puts hash
  @bouy_blocks.push(id_hash)
end
# puts @buoy_blocks1
puts @bouy_blocks

=begin
pre_blocks = page.search('pre a').map { |link| link['href'] }.each do ||
  puts block
end
=end
