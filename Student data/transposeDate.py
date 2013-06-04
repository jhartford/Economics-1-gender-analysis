import csv
import os

path = "/Users/jasonhartford/Documents/Economics/econ 1 data/Economics-1-gender-analysis/Student Data/"
filename = "01. ECON1008 2011 Registered students personal info and matric resultsDIS.csv"
fullname = path+filename

print(fullname)

with open((path+filename),"rb") as f:
	reader = csv.reader(f, delimiter = ',')
#	reader.next()
	print(reader.next()[0:15])
#for line in reader:
#	print(line[3])
f.close()
#try:
#	reader = csv.reader(f)
#	for line in reader:
#		print(line)

#f.close()
