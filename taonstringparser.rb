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

# Put Bouy Numbers Into Data Structure
=begin
@bouys = Array.new
page.css('.result').each do |buoy|
  buoy_number = buoy.css("a[class=noprint]").each do |by|
end
end

@buoys << {:Name => by.content }

# display hash result
puts @buoys
=end

# Get Content Table from CSS
  # content_table = page.css("[id=contenttable]")
  # puts content_table

#XPath Selector //*[@id="contenttable"]/tbody/tr/td[3]/pre[1]/a[1]

=begin
item = content_table.xpath('//*/tbody/tr/td[3]/pre[1]/a[1]') do |it|
  puts it.text
=end

# //*[@id="contenttable"]

# puts thing = page.xpath('//*[@id="contenttable"]')

pre_blocks = page.search('pre a').each do |block|
  puts block.text
end
# puts pre_blocks.map(&:to_html)
# pre_blocks.css('')

pre_blocks = page.search('pre a').map { |link| link['href'] }.each do |block|
  puts block
end



=begin
  # get table rows
  rows = []
  content_table.xpath('//*/tbody/tr/td[3]/pre[1]/a[1]').each_with_index do |row, i|
    rows[i] = {}
    row.xpath('td').each_with_index do |td, j|
      rows[i][headers[j]] = td.text
    end
  end

  p rows
=end


# business_web = page.css("div.links a").map { |link| link['href'] }
