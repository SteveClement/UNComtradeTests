countries=[40,56,58,100,196,203,200,208,233,246,278,280,251,276,300,348,372,381,428,440,442,470,528,616,620,642,703,705,724,752,826]

datadir="./data"
year=1962
end=2016

# UN COMM Trade URL
uitoken="e017c8c439121090e5791a8dc7dfcb6c"
fmt="json"

#wget -O ${datadir}/${year}/${country}.${fmt} "https://comtrade.un.org/api/get?max=50000&type=C&freq=A&px=S1&ps=${year}&r=${reporter}&p=0&rg=1%2C2&cc=673%2C674%2C675%2C676%2C677%2C678&uitoken=${uitoken}&fmt=${fmt}"
