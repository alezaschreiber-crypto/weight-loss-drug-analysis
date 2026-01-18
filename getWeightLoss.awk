BEGIN{
    FS=","
    OFS="|"
}
{
if ($10=="Semaglutide" || $10=="Tirzepatide"){ #if this is a weight loss drug
    NPI[$1]+=$13 #key=NPI data=amount prescribed
    }
}
END{
for (npi in NPI){
    print npi,NPI[npi],YEAR #prints NPI,amount prescribed,year(variable)
}
}




