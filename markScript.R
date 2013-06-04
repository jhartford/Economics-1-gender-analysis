markScript <- function(memo,data){
  n <- length(memo[memo!=""])
  answers <- data[,2:(n+1)]
  blanks <- answers=="z"
  temp <- as.data.frame(matrix(data=NA,nrow = nrow(answers),ncol = ncol(answers)))
  for (i in 1:length(memo[memo!=""])){
    temp[,i] <- -1
    temp[which(answers[,i]==tolower(memo[i])),i]<-4
    temp[which(answers[,i]=="z"),i]<-0
  }
  temp$sn <- gsub(" ","",data$student_number)
  temp$mark <- rowSums(temp[1:n])/(n*4)
  temp$blanks <- rowSums(temp[1:n]==0)
  markScript<-temp
}
t3 = markScript(memo2012$Micro.exam.sem1.2012,june2012)