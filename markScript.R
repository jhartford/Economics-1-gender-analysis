markScript <- function(memo,data){
  n <- length(memo[memo!=""])+5
  answers <- data[,6:n]
  blanks <- answers=="z"
  temp <- as.data.frame(matrix(data=NA,nrow = nrow(answers),ncol = ncol(answers)))
  for (i in 1:length(memo[memo!=""])){
    temp[,i] <- "incorrect"
    temp[which(answers[,i]==tolower(memo[i])),i]<-"correct"
    temp[which(answers[,i]=="z"),i]<-"blank"
  }
  markScript<-temp
}
t3 = markScript(memo2012$Micro.exam.sem1.2012,june2012)