#!/bin/env python
import requests as req
from bs4 import BeautifulSoup

header_fields=["Name","Last modified","Size","Description","Parent Directory"]

realtime_url="http://www.ndbc.noaa.gov/data/realtime2/"
r=req.get(realtime_url)
soup=BeautifulSoup(r.text, 'lxml')
links=soup.find_all("a")

for link in links:
    if link.text in header_fields: 
        continue

    base_href=link.get("href")
    full_url = realtime_url + base_href
    link_data=req.get(full_url)

    ofname=base_href
    ofile=open(ofname,'w')
    ofile.write(link_data.text)
    ofile.close()

