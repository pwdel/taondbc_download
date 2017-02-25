# -*- coding: utf-8 -*-
#Author: Aashish Jain
"""
Spyder Editor

This is a temporary script file.
"""
import pandas as pd
import sys
import requests
import numpy as np
import os

MY_DIR = "/Users/aashishjain/Desktop/ndbc_data/"
STATION_FILE = "station_list.txt"
with open(MY_DIR + STATION_FILE) as station_list:
    stations = station_list.readlines()
    stations = [x.strip() for x in stations]

years = np.arange(1995,2017)

def get_station_data(station, year):
    url = "http://www.ndbc.noaa.gov/view_text_file.php?filename={}h{}.txt.gz&dir=data/historical/stdmet/".format(station, str(year))
    request = requests.get(url)
    return request

for station in stations:
    station_dir = "Station"+station
    newpath=MY_DIR+station_dir 
    if not os.path.exists(newpath):
        os.makedirs(newpath)
    for year in years:
        station_data = get_station_data(station, str(year))
        if station_data.text != "Unable to access data file\n":
            filename = "{}{}/{}.dat".format(MY_DIR,station_dir,str(year))
            with open(filename, "w") as newfile:
                newfile.write(station_data.text)
    if len(os.listdir(newpath+"/"))== 0:
        os.rmdir(newpath+"/")
