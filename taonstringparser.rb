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
page.search('pre a').map { |link| link['href'] }.each do |links|
  # puts block.text
  id_hash = { :Bouyid => block.text, :Bouyweb => links }
  # puts hash
  @bouy_blocks.push(id_hash)
end
end

#puts @bouy_blocks

# Get headers, the keys for each hash key-value pair
headers = @bouy_blocks[0].keys

# Open CSV File, Write Headers Into First Row, Populate Data With Hash
CSV.open("data.csv", "wb", headers: :first_row) do |csv|
  # write the headers to the CSV
  csv << headers
  # iterate over the hashes
  @bouy_blocks.each do |bz|
  # extract values and write to CSV file
  csv << bz.values_at(*headers)
end
end
