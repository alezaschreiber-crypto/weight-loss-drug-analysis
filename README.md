# weight-loss-drug-analysis

## Overview
This project analyzes large-scale Medicare prescription data to investigate
whether increased use of weight-loss drugs correlates with changes in
hypertension and cholesterol medication usage, and whether prescription
patterns vary by neighborhood income level.

**Note** Raw datasets not included due to size constraints
This project relies on large datasets that cannot be included in this repository, so the full pipeline cannot be executed through this repo. This repository focuses on code, methodology and workflow.

## Hypotheses
1. As prescriptions for weight-loss drugs increase, prescriptions for
   hypertension and cholesterol medications decrease, as weight-loss drugs
   may mitigate these conditions.
2. Weight-loss drug prescriptions are more prevalent in higher-income
   neighborhoods.

##Data Sources:
   1) IRS Income Tax Data from 2020- to estimate the average income of different neighborhoods (the 2020 data is assumed to be accurate for both 2024 and 2019). 
   2) 2019 Medicare Prescriptions- to get the weight loss drugs & their relevant data, as well as the blood pressure and cholesterol drugs & their relevant data.
   3) 2024 Medicare Prescriptions- same as above
   4) Doctor NPI Numbers- to map the prescriptions in the Medicare file to their zip codes

##Methodology:
   - Identified Semaglutide or Tirzepatide (weight loss drugs) in the Medicare file and saved the doctor NPI number, # prescriptions given, and year.
   - Identified number of hypertension and cholesterol drugs and the Medicare file and extracted the same data as above.
   - Mapped doctor NPI numbers to their zip codes
   - Replaced each NPI number with the corresponding zip code, which gave provided the zip code, prescription amount and year for each of the 2 categories of drugs.
   - Computed the average income per zip code by dividing the Adjusted Gross Income by number of returns.
   - Computed the ratio of weight loss drug prescriptions (2024/2019) and blood pressure/cholesterol prescriptions (2024/2019) for each zip code to compare the growth.
   - Visualized correlations between prescription growth and income using
  scatter plots, with marker size representing weight-loss drug growth.

## Results
- No strong correlation was observed between increases in weight-loss drug prescriptions and decreases in hypertension and cholesterol medication
- Growth in hypertension and cholesterol medication was generally low, indicating minimal change between 2019 and 2024.
- Weight-loss drug prescriptions showed more variability in growth across
  zip codes.
- No strong correlation was observed between neighborhood income and weight-loss drug prescription.    

##Limitations and Future Work
- Medicare datasets do not include diagnoses, limiting the ability to determine whether the prescriptions were directly targeting weight loss.
- Dosage strength information was not available, so reductions in dosage strength could not be considered.
- Analysis was limited to Medicare data and may not apply to the general population.
- Future work could incorporate diagnosis data and non-Medicare prescriptions to further investigate.
