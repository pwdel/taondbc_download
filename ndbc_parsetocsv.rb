# Include the Necessary Tools

require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'
require 'csv'
require 'pp'

# Pull The Page Down
@t0 = Time.now
# processing...
@t1 = Time.now
@time = @t1 - @t0 # Current time
puts "Pulling down http://www.ndbc.noaa.gov/to_station.shtml..."


page = Nokogiri::HTML(RestClient.get("http://www.ndbc.noaa.gov/to_station.shtml")) do |config|
  config.strict.noblanks
end

puts "#{@time} seconds"

puts "Setting up array..."
@bouy_blocks = Array.new
page.search('pre a').each do |block|
page.search('pre a').map { |link| link['href'] }.each do |links|
  # puts block.text
  id_hash = { :Bouyid => block.text, :Bouyweb => "http://www.ndbc.noaa.gov/"+links }
  # puts hash
  @bouy_blocks.push(id_hash)
end
end
@t2 = Time.now
@time = @t2 - @t0
puts "#{@time} seconds"

#puts @bouy_blocks

# Get headers, the keys for each hash key-value pair
headers = @bouy_blocks[0].keys
puts "Entering structured data into csv..."
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

puts "Finished Adding to CSV"
@t3 = Time.now
@time = @t3 - @t0
puts "#{@time} seconds"
puts "Finished."
