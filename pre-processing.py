import re,os
path = "C:\\Users\\A0033620\\Dropbox\\Documents\\Economics\\econ 1 data\\Economics-1-gender-analysis\\"
for f in os.listdir(path):
    filename = f.rsplit(".",1)[0]
    f = open(f,"rb")
    o = open("out\\"+filename+".csv","w")
    for line in f:
        if len(line.split())!=6:
            o.write(",".join(re.sub(r'(\d)\s(\d)',r'\1\2',line).split())+"\n")
        else:
            o.write(",".join(line.split())+"\n")
    f.close()
    o.close()
