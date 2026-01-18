BEGIN{
    FS="|"
    OFS="|"
}
{
    print $1,substr($25,1,5),YEAR #print NPI number, zip code, year(variable)
}
