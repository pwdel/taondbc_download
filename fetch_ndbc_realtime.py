#!/bin/env python
import requests as req
from bs4 import BeautifulSoup


# header fields are links and we should igonore them
header_fields = ["Name", "Last modified", "Size", "Description", "Parent Directory"]

# page with all the links for files
realtime_url = "http://www.ndbc.noaa.gov/data/realtime2/"

# read the website html and find the links to the files
r = req.get(realtime_url)
soup = BeautifulSoup(r.text, 'lxml')
links = soup.find_all("a")

# skip the header links
for link in links:
    if link.text in header_fields: 
        continue

    # get the link to the file
    base_href = link.get("href")
    full_url = realtime_url + base_href
    link_data = req.get(full_url)

    # save the file
    file_name = base_href + '.gz'
    with gzip.open(file_name, 'wb') as f:
        f.write(link_data.text)
