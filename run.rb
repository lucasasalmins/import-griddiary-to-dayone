#!/usr/bin/ruby

# this script imports .txt diary entry exports from Grid Diary
# it assumes the files have the format e.g. 'Diary - 1 April 2015'

# import to DayOne journal is using the DayOne classic cli
# docs found here http://dayoneapp.com/tools/cli-man/

# Use and modify freely, attribution appreciated

require 'date'

# directory with invidividual .txt files to import
data = './data/*.txt'

# loop through each file in directory
# and create a dayone journal entry
Dir.glob(data) do |item|
  # read contents of item
  contents = File.read(item)
  
  # read filename - strip 'Diary - '
  filename = File.basename(item, ".*").sub(/^Diary - /, '')

  # get date from filename
  d     = Date.parse(filename)
  month = d.strftime('%m')
  day   = d.strftime('%d')
  year  = d.strftime('%y')
  
  # create new entry with contents of file as body and date from 
  # filename as the entry date
  %x{echo "#{contents}" | dayone -d="#{month}/#{day}/#{year}" new}
end

