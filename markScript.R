markScript <- function(memo,data){
  n <- length(memo[memo!=""])+5
  answers <- data[,6:n]
  blanks <- answers=="z"
  temp <- as.data.frame(matrix(data=NA,nrow = nrow(answers),ncol = ncol(answers)))
  #temp <- toupper(as.matrix(answers)) == toupper(tempMemo)
  #temp <- as.data.frame(temp)

  for (i in 1:length(memo[memo!=""])){
    temp[,i] <- "incorrect"
    temp[which(answers[,i]==tolower(memo[i])),i]<-"correct"
    temp[which(answers[,i]=="z"),i]<-"blank"
  #  temp[is.na(answers[,i]),i]<-NA
  }
  markScript<-temp
#  markScript <- as.data.frame(lapply(temp,function(x,blanks) {ifelse(x,"correct","incorrect")},blanks))
#  markScript <- as.data.frame(lapply(temp,function(x,blank) ifelse(x,"correct","incorrect"),blanks))
#  print(answers=="z")
}
t3 = markScript(memo2012$Micro.exam.sem1.2012,june2012)