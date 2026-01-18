import pyspark
sc=pyspark.SparkContext()
def info(line):
    fields=line.split(',')
    try: zip5=fields[2]
    except: zip5='00000'
    try: returns=float(fields[4])
    except: returns=0
    try: AGI=float(fields[20])
    except: AGI=0
    return zip5,(AGI,returns)  #returns zipcode,AGI and number of returns

fileLines=sc.textFile('IRSIncomeTax2020.gz')
data=fileLines.map(info)
goodZips=data.filter(lambda x: x[0]!='00000' and x[0]!='99999') #filter out fake zip codes
summed=goodZips.reduceByKey(lambda x,y: (x[0]+y[0],x[1]+y[1])) #sum up AGI and returns per zip code
goodReturns=summed.filter(lambda x: x[1][1]>0) #filter out returns=0
getAVG=goodReturns.map(lambda x: (x[0],x[1][0]/x[1][1])) #find avg income by dividing AGI/returns
formatted=getAVG.map(lambda x: x[0]+'|'+str(x[1])) #format for pipe-delimited output
formatted.saveAsTextFile('zipIncomeSpark')
