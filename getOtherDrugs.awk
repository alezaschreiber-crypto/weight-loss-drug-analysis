BEGIN{
    FS=","
    OFS="|"
    keys="Hydrochlorothiazide Chlorthalidone Indapamide Lisinopril Enalapril Ramipril Benazepril Losartan Valsartan Olmesartan Candesartan Nifedipine Diltiazem Verapamil Amlodipine Atorvastatin Rosuvastati Simvastatin Pravastatin Lovastatin Fluvastatin"  #these are the names of drugs I'm looking for
    n=split(keys,arr," ")
    for (i=1;i<=n;i++){  #load the drug names into an array
        drugs[arr[i]]=1
}       
}
{
    for(d in drugs){
	if (index($10,d)>0){  #if this drug is one of the ones on my list:
	    NPI[$1]+=$13  #key=NPI number data=amount of pills
	}
    }
}
END{
    for (npi in NPI){
	print npi,NPI[npi],YEAR #print NPI number, amount prescribed, year (variable) 
    }
}
