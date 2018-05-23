#!/usr/bin/env python3

import json
import os

from config import *

with open('reporterAreas.json') as fCountries:
    jCountries = json.load(fCountries)
    fCountries.close()

# print(jCountries)
#print(countries)

cYear = year
while cYear < end:
    print(str(cYear))
#    for countryID in countries:
#        for jID in jCountries['results']:
#            print(jID[countryID])
    pDir = os.path.join(datadir + '/' + str(year) + '/' + fmt)
    noDataDir = os.path.join(datadir + '/' + str(year) + '/' + 'noData')
    pFiles = os.listdir(pDir)
    noDataFiles = os.listdir(noDataDir)
    ##for file in noDataFiles:
    ##    if file.endswith('csv'):
    ##        print(str(cYear) + ',' + file)
    for file in pFiles:
        pFile=os.path.join(pDir+'/'+file)
        if file.endswith(fmt):
            with open(pFile) as f:
                jFile = json.load(f)
                if not jFile['dataset']:
                    print('No data for {} in year {}'.format(file, str(year)))
                else:
                    print('We have data for {} in year {}'.format(file, str(year)))
                f.close()
    cYear += 1
