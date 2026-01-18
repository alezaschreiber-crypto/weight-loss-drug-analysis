import matplotlib.pyplot as plt
import numpy as np
import math
income=[]
WL=[]
f=open("dataPlot2")
line=f.readline()
while line:
    fields=line.split("|") #load arrays of avg income and weight loss drug amount (log), per zip code
    income.append(math.log(float(fields[1])+1.0)) 
    WL.append(5*math.log(float(fields[2])+1.0))
    line=f.readline()
f.close()

plt.style.use('default')

x = income #x-axis=avg income
y = WL     #y-axis= weight loss prescriptions

# plot
fig, ax = plt.subplots()

ax.scatter(x, y, alpha=0.2)
ax.set_ylabel("Weight loss drug prescriptions (5*log)")
ax.set_xlabel("Average income (log)")
ax.set_title("Weight loss drug prescriptions per zip in 2024 and Average Income")
             

fig.savefig("LinuxProject2.pdf")
