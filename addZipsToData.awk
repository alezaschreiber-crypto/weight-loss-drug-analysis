BEGIN{
    FS="|"
    OFS="|"
    while((getline< "NPIzips")>0){
	if ($3==2024){ #if this is 2024 data:
	NPI24[$1]=$2   #key=NPI data=zip
	}
	else{
	    NPI19[$1]=$2 #this is 2019 data (use the older dataset in case a doctor moved)
}
}
}
{
#reading input file:
    if($1 in NPI24 && $3==2024){ #if it's 2024, and this NPI is in our array
print NPI24[$1],$2,$3  #print NPI,amount prescribed,2024
}
    else if($1 in NPI19 && $3==2019){ #if it's 2019 and this NPI is in array
	    print NPI19[$1],$2,$3 #print NPI, amount prescribed,2019
}
}
     
