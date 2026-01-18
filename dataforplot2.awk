BEGIN{
    FS="|"
    OFS="|"
    while ((getline<"weightLossStep2")>0){
	if($3=="2024"){       #looking only at 2024 info
	    prescriptions[$1]=$2 #key=zip data=prescription amount
	}
    }
    while ((getline<"zipIncome")>0){
	income[$1]=$2 #key=zip data=avg income
    }
    for (zip in prescriptions){ #for each zip in prescriptions that is also in income:
	if (zip in income){
	    print zip,income[zip],prescriptions[zip] #print zip, avg income, prescription amount
	}
    }
}
