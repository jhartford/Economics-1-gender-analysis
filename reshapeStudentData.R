library(ggplot2)
library(plyr)

ECON1008.2012 <- read.csv("Student data/02. ECON1008 2012 Registered students personal info and matric resultsDIS.csv", sep=",")
ECON1008.2013 <- read.csv("Student data/03. ECON1008 2013 Registered students personal info and matric resultsDIS.csv", sep=",")
memo2012 <- read.csv("memos/2012-memo.csv", sep=",")

EC1008.2012<-ECON1008.2012[ECON1008.2012$Test.Segment.Code=="AGGREGATE",]
EC1008.2013<-ECON1008.2013[ECON1008.2013$Test.Segment.Code=="AGGREGATE",]
EC1008.2012$sn <- gsub(pattern = "[A-Z]",replacement="",EC1008.2012$Student.Number)
EC1008.2011<-ECON1008.2011[ECON1008.2011$Test.Segment.Code=="AGGREGATE",]

t1.2012<- read.csv("out/econ1008-20120327.csv", sep = ",")
t1.2012.marked <- markScript(memo2012$Micro.T1.sem1.2012,t1.2012)
t1.2012.full<-merge(EC1008.2012,t1.2012.marked)

hist(t1.2012.full[t1.2012.full$Sex=="F",]$blanks,freq = FALSE)
plot(density(t1.2012.full[ t1.2012.full$Sex=="M",]$blanks,bw=0.5),col="red")
lines(density(t1.2012.full[t1.2012.full$Sex=="F",]$blanks,bw=0.5))

mod.lm <- lm(mark ~ Sex + Race.Description + Test.Segment.Percentile + Age, data = t1.2012.full)
summary(mod.lm)

## Plots aren't very different when you remove blanks = 0

plot(density(t1.2012.full[(t1.2012.full$blanks!=0) & t1.2012.full$Sex=="M",]$blanks,bw=0.5),col="red")
lines(density(t1.2012.full[(t1.2012.full$blanks!=0) & t1.2012.full$Sex=="F",]$blanks,bw=0.5),col="blue")

# Proportion who answered everything:
sum(t1.2012.full[(t1.2012.full$blanks==0),]$Sex=="F")/sum(t1.2012.full$Sex=="F")
sum(t1.2012.full[(t1.2012.full$blanks==0),]$Sex=="M")/sum(t1.2012.full$Sex=="M")

# Compare the years
EC1008.2013<-ECON1008.2012[ECON1008.2012$Test.Segment.Code=="AGGREGATE",]
EC1008.2013$sn <- gsub(pattern = "[A-Z]",replacement="",EC1008.2012$Student.Number)

t1.2013<- read.csv("out/econ1008-20120327.csv", sep = ",")
t1.2013.marked <- markScript(memo2012$Micro.T1.sem1.2012,t1.2012)
t1.2013.full<-merge(EC1008.2013,t1.2013.marked)


# Melt questions
t1.2012.limited <- t1.2012.full[,c("sn","Test.Segment.Percentile","blanks","mark","Sex","V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15")]
t1.2012.melted <- melt(t1.2012.limited,id=c("sn","Test.Segment.Percentile","blanks","mark","Sex"))
names(t1.2012.melted)[names(t1.2012.melted)=="variable"]<-"question"
t1.2012.melted$blank <- "answered" 
t1.2012.melted$blank[t1.2012.melted$value == 0] <- "blank" 
t1.2012.melted$blank <- as.factor(t1.2012.melted$blank)
mod.melted = glm(blank~Test.Segment.Percentile+mark+Sex,data=t1.2012.melted,family=binomial(link="logit"))

## Plots


ggplot(t1.2012.full,aes(x=(blanks))) + 
  geom_histogram(data=subset(t1.2012.full,Sex == 'M'),fill = "red", alpha = 0.5) +
  geom_histogram(data=subset(t1.2012.full,Sex == 'F'),fill = "blue", alpha = 0.5)
#Histograms

cdf <- ddply(t1.2012.full, .(Sex), summarise, blanks.mean=mean(blanks), blanks.sd=sd(blanks))

ggplot(t1.2012.full,aes(x=blanks, fill = Sex)) + 
  geom_histogram(aes(y=..density..), binwidth = 0.5, alpha = 0.5,position = "identity") +
  geom_vline(data=cdf, aes(xintercept=c(blanks.mean-blanks.sd,blanks.mean+blanks.sd),  colour=Sex),
             linetype="dashed", size=0.5,alpha=0.5)+
  geom_vline(data=cdf, aes(xintercept=c(blanks.mean),  colour=Sex),
           linetype="dashed", size=1)

ggplot(t1.2012.full[t1.2012.full$blanks!=0,],aes(x=blanks, fill = Sex)) + 
  geom_histogram(aes(y=..density..), binwidth = 0.5, alpha = 0.5,position = "identity") +
  geom_vline(data=cdf, aes(xintercept=c(blanks.mean-blanks.sd,blanks.mean+blanks.sd),  colour=Sex),
             linetype="dashed", size=0.5,alpha=0.5)+
               geom_vline(data=cdf, aes(xintercept=c(blanks.mean),  colour=Sex),
                          linetype="dashed", size=1)

#Density plots
ggplot(t1.2012.full,aes(x=blanks, fill = Sex)) + 
  geom_density(alpha = 0.5) +
  geom_vline(data=cdf, aes(xintercept=c(blanks.mean-blanks.sd,blanks.mean+blanks.sd),  colour=Sex),
             linetype="dashed", size=0.5,alpha=0.5)+
               geom_vline(data=cdf, aes(xintercept=c(blanks.mean),  colour=Sex),
                          linetype="dashed", size=1)


ggplot(t1.2012.full[t1.2012.full$blanks!=0,],aes(x=blanks, fill = Sex)) + 
  geom_density(alpha = 0.5, binwidth=1) +
  geom_vline(data=cdf, aes(xintercept=c(blanks.mean-blanks.sd,blanks.mean+blanks.sd),  colour=Sex),
             linetype="dashed", size=0.5,alpha=0.5)+
               geom_vline(data=cdf, aes(xintercept=c(blanks.mean),  colour=Sex),
                          linetype="dashed", size=1)
  #+geom_density(binwidth = 0.5, alpha = 0.2)