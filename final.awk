BEGIN{
    FS="|"
    OFS="|"
    
    file1="zipIncome"
    while ((getline<file1)>0){ #load up array with zip codes and their avg income
	zips[$1]=$2  #key=zip data=income
    }
    close(file1)
    file2="WLRatio"
    while((getline<file2)>0){ #load array with zip codes and weight loss drug ratio (2024/2019)
	wl[$1]=$2   #key= zip data=ratio
    }
    close(file2)
    file3="BPRatio" #load array with zip codes and cholesterol/blood pressure drug ratio (2024/2019)
    while((getline<file3)>0){
	od[$1]=$2
    }
    close(file3)
    for (key in zips){ #for each zip code:
	if (key in wl && key in od){ #if we have that zip code in both drug arrays
	print zips[key],wl[key],od[key],key #print income, weight loss ratio, cholesterol/blood pressure ratio, zip code
    }
    }
}
