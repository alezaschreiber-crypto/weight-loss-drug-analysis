import matplotlib.pyplot as plt
import numpy as np
import math
income=[]
BP=[]
WL=[]
f=open("finalData")
line=f.readline()
while line:  #load arrays of income, weight loss ratio, blood pressure/cholesterol ratio for each zip code
    fields=line.split("|")
    income.append(math.log(float(fields[0])+1.0)) #income
    BP.append(math.log(float(fields[2])+1.0))     #blood pressure/cholesterol drug ratio (2024/2019)
    WL.append(10*math.log(float(fields[1])+1.0))   #weight loss drug ratio (2024/2019)
    line=f.readline()
f.close()

plt.style.use('default')

x = income #y-axis is avg income
y = BP     #x-axis is blood pressure/cholesterol ratio
sizes =WL  #size of the circles=ratio of weight loss drug 

# plot
fig, ax = plt.subplots()

ax.scatter(x, y, s=sizes, alpha=0.3)
ax.set_ylabel("Ratio of blood pressure/cholesterol drugs (2024/2019)(log)")
ax.set_xlabel("Average income (log)")
ax.set_title("Weight loss drug vs cholesterol/blood pressure drug use, by zip code (log)\n"
             "Each dot= ratio of weight loss drug (2024/2019)(10*log)")

fig.savefig("LinuxProject.pdf")
