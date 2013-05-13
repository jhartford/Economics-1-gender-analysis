stringToAnswers <- function(string,value.code = c(a="X....",b=".X...",c="..X..",d="...X.",e="....X",z="....."),debug=FALSE){
  s.length <- nchar(as.character(string))
  if (debug) print(substring(string,seq(1,875,5),seq(5,875,5)))
  names(value.code)[match(substring(string,seq(1,875,5),seq(5,875,5)),value.code)]
}

processFrame <- function(df){
  dat<- data.frame(t(sapply(df$V6,stringToAnswers)))
  names(dat)<-paste("q",1:175)
  df <- data.frame(df,dat)
  df$V6 <- NULL
  return (df)
}

setwd("C:\\Users\\A0033620\\Dropbox\\Documents\\Economics\\econ 1 data\\Economics-1-gender-analysis\\out")
for (f in list.files()){
  print(f)
  data <- read.csv(f,sep=",",head=FALSE)
  dat<- data.frame(t(sapply(data$V6,stringToAnswers)))
  names(dat)<-paste("q",1:175)
  data <- data.frame(data,dat)
  data$V6 <- NULL
  write.table(data,file=paste("edit\\",f,sep=""),sep=",",quote=FALSE)
}
econ1000.2010 <- read.csv("econ1000-20100311.csv",sep=",",head=FALSE)