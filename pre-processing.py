import re
import os

path = "/Users/jasonhartford/Documents/Economics/econ 1 data/Economics-1-gender-analysis/"

def convert(Xdot):
    out = ""
    for i in range(0,175):
        if (Xdot[i*5:(i+1)*5] == "X...."): out = out + ",a"
        elif (Xdot[i*5:(i+1)*5] == ".X..."): out = out + ",b"
        elif (Xdot[i*5:(i+1)*5] == "..X.."): out = out + ",c"
        elif (Xdot[i*5:(i+1)*5] == "...X."): out = out + ",d"
        elif (Xdot[i*5:(i+1)*5] == "....X"): out = out + ",e"
        elif (Xdot[i*5:(i+1)*5] == "....."): out = out + ",z"
        else: out = out+",NA"
    return out

title = "student_number"
for i in range (1,176):
    title = title + ",q" + str(i)

for f in os.listdir(path):
    filename = f.rsplit(".",1)[0]
    try:
        ext = f.rsplit(".",1)[1]
        if (ext== "dat"):
            f = open(f,"rb")
            o = open("out/"+filename+".csv","w")
            o.write(title+"\n")
            for line in f:
                #o.write(line[0:20]+","+line[24:28]+","+line[29:34]+","+line[40:47]+","+line[48:924])
                if (len(line)>10):
                    o.write(line[40:47]+convert(line[48:924])+"\n")
                #ans = re.search(r'[\.\X]{875}',line)
                #print(len(line))
                #if ans:
                #    answer = ans.group(0)
                #sn = re.search(r'(\b\d[\d\s\*]{4}\d\b|\b\d[\d\s\*]{5}\d\b)',line)
                #sn = re.search(r'(N\s[\d\*\s]{6,})',line)
                #if sn:
                #    student = sn.group(0)[2:].strip()
             #   if len(line.split())!=6:
             #       o.write(",".join(re.sub(r'(\d)\s(\d)',r'\1\2',line).split())+"\n")
             #   else:
                   # o.write(",".join(line.split())+"\n")
            f.close()
            o.close()
    except IndexError:
        ext = ""
