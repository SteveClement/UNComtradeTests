#!/usr/bin/env python3

import json
import os

from config import *

with  open('reporterAreas.json') as fCountries:
    jCountries = json.load(fCountries)
    fCountries.close()

#print(jCountries)
print(countries)

cYear = year
while cYear < end:
    print(str(cYear))
    pDir = os.path.joint(datadir+year+fmt)
    cYear += 1
