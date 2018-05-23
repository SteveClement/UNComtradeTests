#!/usr/bin/env python3

import json
import os

from config import *

with open('reporterAreas.json') as fCountries:
    jCountries = json.load(fCountries)
    fCountries.close()

# the json from reporterAreas looks like this: {'id': '4', 'text': 'Afghanistan'}
# You can skip index[0] as it only contains this: {'id': 'all', 'text': 'All'}
# print(jCountries['results'][1])         -> {'id': '4', 'text': 'Afghanistan'}
# print(jCountries['results'][1]['id'])   -> 4
# print(jCountries['results'][1]['text']) -> Afghanistan
# Numerical list of countries to be processed, this gets set in config.py and if for reference only.
# countries=[40,56,58,100,196,203,200,208,233,246,278,280,251,276,300,348,372,381,428,440,442,470,528,616,620,642,703,705,724,752,826]
# print(countries)

print(f"Extracting data from {year} to {end} for {len(countries)} countries.")
print("---------------------------------------------------")
print('Year, Country, Sum')
cYear = year
while cYear < end:
#    for countryID in countries:
#        for jID in jCountries['results']:
#            print(jID[countryID])
    pDir = os.path.join(datadir + '/' + str(cYear) + '/' + fmt)
    pFiles = os.listdir(pDir)
    for file in pFiles:
        pFile=os.path.join(pDir+'/'+file)
        if file.endswith(fmt):
            #print(f'Processing file {pFile} for {cYear}')
            sum=0
            entry = []
            with open(pFile) as f:
                jFile = json.load(f)
                if not jFile['dataset']:
                    #print('No data for {} in year {}'.format(file[:-5], str(year)))
                    print(f'{cYear},{file[:-5]},noData')
                else:
                    #print('We have data for {} in year {}'.format(file[:-5], str(year)))
                    for entry in jFile['dataset']:
                        # code 1 == Import -- code 2 == Export
                        if entry['period'] != cYear:
                            print(f"/!\ {file[:-5]} {cYear} got {entry['period']}")
                        if entry['rgCode'] == 2 and entry['NetWeight'] is not None:
                            #try:
                            sum += entry['NetWeight']
                            #except TypeError as e:
                            #    print(f"Errors in: {cYear} {file[:-5]} {print(type(entry['NetWeight']))}")
                    #print(f'Sum for {file[:-5]} in year {cYear} is {sum}')
                    print(f'{cYear},{file[:-5]},{sum}')
    cYear += 1
