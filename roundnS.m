function outData=roundnS(inData, nEps)

quantVal=10^nEps;
outData=round(inData/quantVal)*quantVal;