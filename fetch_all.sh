#!/usr/bin/env bash
countries="40 56 58 100 196 203 200 208 233 246 278 280 251 276 300 348 372 381 428 440 442 470 528 616 620 642 703 705 724 752 826"

datadir="./data"
year="1962"
end="2017"

# UN COMM Trade URL
##uitoken="e017c8c439121090e5791a8dc7dfcb6c"
uitoken="702cdf771f21634410207d1ddeaddf0b"
fmt="json"

while [ "$year" -lt "$end" ]; do
  mkdir -p ${datadir}/${year}/noData
  mkdir -p ${datadir}/${year}/${fmt}
  for reporter in `echo $countries`; do
    if [ "$reporter" == "40" ]; then country="Austria"; fi
    if [ "$reporter" == "56" ]; then country="Belgium"; fi
    if [ "$reporter" == "58" ]; then country="Belgium-Luxembourg"; fi
    if [ "$reporter" == "100" ]; then country="Bulgaria"; fi
    if [ "$reporter" == "196" ]; then country="Cyprus"; fi
    if [ "$reporter" == "203" ]; then country="Czechia"; fi
    if [ "$reporter" == "200" ]; then country="Czechoslovakia"; fi
    if [ "$reporter" == "208" ]; then country="Denmark"; fi
    if [ "$reporter" == "233" ]; then country="Estonia"; fi
    if [ "$reporter" == "246" ]; then country="Finland"; fi
    if [ "$reporter" == "278" ]; then country="Fmr_Dem._Rep._of_Germany"; fi
    if [ "$reporter" == "280" ]; then country="Fmr_Fed._Rep._of_Germany"; fi
    if [ "$reporter" == "251" ]; then country="France"; fi
    if [ "$reporter" == "276" ]; then country="Germany"; fi
    if [ "$reporter" == "300" ]; then country="Greece"; fi
    if [ "$reporter" == "348" ]; then country="Hungary"; fi
    if [ "$reporter" == "372" ]; then country="Ireland"; fi
    if [ "$reporter" == "381" ]; then country="Italy"; fi
    if [ "$reporter" == "428" ]; then country="Latvia"; fi
    if [ "$reporter" == "440" ]; then country="Lithuania"; fi
    if [ "$reporter" == "442" ]; then country="Luxembourg"; fi
    if [ "$reporter" == "470" ]; then country="Malta"; fi
    if [ "$reporter" == "528" ]; then country="Netherlands"; fi
    if [ "$reporter" == "616" ]; then country="Poland"; fi
    if [ "$reporter" == "620" ]; then country="Portugal"; fi
    if [ "$reporter" == "642" ]; then country="Romania"; fi
    if [ "$reporter" == "703" ]; then country="Slovakia"; fi
    if [ "$reporter" == "705" ]; then country="Slovenia"; fi
    if [ "$reporter" == "724" ]; then country="Spain"; fi
    if [ "$reporter" == "752" ]; then country="Sweden"; fi
    if [ "$reporter" == "826" ]; then country="United_Kingdom"; fi

    if [ ! -f "${datadir}/${year}/${fmt}/${country}.${fmt}" ] && [ ! -f "${datadir}/${year}/noData/${country}.${fmt}" ]; then
      echo "Fetching data for ${country} for ${year}"
      wget -O ${datadir}/${year}/${fmt}/${country}.${fmt} "https://comtrade.un.org/api/get?max=50000&type=C&freq=A&px=S1&ps=${year}&r=${reporter}&p=0&rg=1%2C2&cc=673%2C674%2C675%2C676%2C677%2C678&uitoken=${uitoken}&fmt=${fmt}"
      wget_code=$?
      if [ "$wget_code" == "8" ]; then killall -HUP tor; echo "kicked tor, press enter when ready"; read; torify wget -O ${datadir}/${year}/${fmt}/${country}.${fmt} "https://comtrade.un.org/api/get?max=50000&type=C&freq=A&px=S1&ps=${year}&r=${reporter}&p=0&rg=1%2C2&cc=673%2C674%2C675%2C676%2C677%2C678&uitoken=${uitoken}&fmt=${fmt}" ; fi
      grep "No data matches your query or your query is too complex." ${datadir}/${year}/${fmt}/${country}.${fmt}; if [ "$?" == "0" ]; then mv ${datadir}/${year}/${country}.${fmt} ${datadir}/${year}/noData/; fi
    fi
  done
  year=$(expr $year + 1)
done

# Clean 0 byte files: find . -type f -size 0 -exec rm {} \;
# Austria
##https://comtrade.un.org/api/get?max=50000&type=C&freq=A&px=S1&ps=1962&r=40&p=0&rg=1%2C2&cc=TOTAL&uitoken=e017c8c439121090e5791a8dc7dfcb6c&fmt=csv
# Belgium
##https://comtrade.un.org/api/get?max=50000&type=C&freq=A&px=S1&ps=1962&r=56&p=0&rg=1%2C2&cc=TOTAL&uitoken=e017c8c439121090e5791a8dc7dfcb6c&fmt=csv
# Belgium-Luxembourg
##https://comtrade.un.org/api/get?max=50000&type=C&freq=A&px=S1&ps=2001&r=58&p=0&rg=1%2C2&cc=TOTAL&uitoken=e017c8c439121090e5791a8dc7dfcb6c&fmt=json
