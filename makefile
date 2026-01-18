all: LinuxProject.pdf LinuxProject2.pdf
	echo "Everything has been built"
clean:
	rm weightLoss otherDrugs NPIzips zipIncome weightLossStep2 otherDrugsStep2 BPRatio WLRatio finalData dataPlot2 LinuxProject.pdf LinuxProject2.pdf
	rm -r zipIncomeSpark
#make second plot:
LinuxProject2.pdf: dataPlot2 makeplot2.py 
	python3 makeplot2.py
#use intermediate files to extract data for second plot (weight loss prescripton amount and avg income): 
dataPlot2: weightLossStep2 zipIncome dataforplot2.awk 
	gawk -f dataforplot2.awk >dataPlot2
#make main plot:
LinuxProject.pdf: finalData makeplot.py 
	python3 makeplot.py
#synthesize data needed to plot (avg income, weight loss ratio, hypertension/cholesterol ratio, zip code):
finalData: zipIncome WLRatio BPRatio final.awk 
	gawk -f final.awk > finalData
#compute ratio of cholesterol/blood pressure drugs in 2024/2019:
BPRatio: otherDrugsStep2 ratio.awk
	gawk -f ratio.awk otherDrugsStep2 > BPRatio
#compute ratio of weight loss drugs in 2024/2019:
WLRatio: weightLossStep2 ratio.awk
	gawk -f ratio.awk weightLossStep2 >WLRatio
#replace the NPI numbers with corresponding zip codes, for weight loss drug data:
weightLossStep2: weightLoss NPIzips addZipsToData.awk
	gawk -f addZipsToData.awk weightLoss > weightLossStep2
#replace the NPI numbers with corresponding zip codes, for blood pressure/hypertension drug data:
otherDrugsStep2: otherDrugs NPIzips addZipsToData.awk
	gawk -f addZipsToData.awk otherDrugs> otherDrugsStep2
#get the zip code that corresponds to each NPI number:
NPIzips: NPI2024 getNPIzips.awk
	zcat NPI2024| gawk -v YEAR=2024 -f getNPIzips.awk > NPIzips
	zcat NPI2021| gawk -v YEAR=2019 -f getNPIzips.awk >> NPIzips #using older dataset for 2019, mitigate the amount of incorrect zips because doctors moved
#in case Spark makes multiple files- compile into 1
zipIncome: zipIncomeSpark/_SUCCESS 
	cat zipIncomeSpark/part-* > zipIncome
#compute the avg income per zip code, by doing AGI/returns                     
zipIncomeSpark/_SUCCESS: IRSIncomeTax2020.gz zipcodes.py
	python3 zipcodes.py
#get all the weight loss drugs, along with NPI number and year
weightLoss: MedicarePrescriptionsF24 MedicarePrescriptions19 getWeightLoss.awk
	zcat MedicarePrescriptions19 | gawk -v YEAR=2019 -f getWeightLoss.awk >weightLoss
	zcat MedicarePrescriptionsF24 | gawk -v YEAR=2024 -f getWeightLoss.awk >>weightLoss #run this script on 2 diff input files to the same output file
#get all the blood pressure/high cholesterol drugs, along with NPI number and year
otherDrugs: MedicarePrescriptionsF24 MedicarePrescriptions19 getOtherDrugs.awk
	zcat MedicarePrescriptions19 | gawk -v YEAR=2019 -f getOtherDrugs.awk > otherDrugs
	zcat MedicarePrescriptionsF24 | gawk -v YEAR=2024 -f getOtherDrugs.awk >>otherDrugs ##run this script on 2 diff input files to the same output file 
