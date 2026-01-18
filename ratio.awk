BEGIN{
    OFS="|"
    FS="|"
}
$3==2019{ #first process 2019 data (it's always first in input file)
    nineteen[$1]=$2 #key=zip5 data=amount prescribed 
    next
}
{
    twentyfour[$1]=$2 #then process 2024 data- key=zip, data=amount prescribed
}
END{
    for (zip in twentyfour){ #for each 2024 zip
	if (zip in nineteen && nineteen[zip]>0){ #if it's also in 2019 data, and 2019 data has more than 0 prescriptions
	    print zip, twentyfour[zip]/nineteen[zip] #print zip5, ratio of prescriptions in 2024/2019
	}
    }
}
