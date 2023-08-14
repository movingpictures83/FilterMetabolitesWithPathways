#########################################################################################################################
#########################################################################################################################
###### PROJECT:        DBNs
###### NAME:           CreateStyle.R
###### AUTHOR:         Daniel Ruiz-Perez, PhD Student
###### AFFILIATION:    Florida International University
###### 
###### DESCRIPTION:    This file converts a .graphml file into a csv file.
######                  It also generates another csv with the ids of the metabolites as columns
#########################################################################################################################
#########################################################################################################################

library(scales)
library(stringr)
#options("scipen"=100, "digits"=4)

#folder = "C:/Users/danir/Google Drive/FIU/RESEARCH/DBNs/Heterogeneous/SupportingCode/ValidateEdges/" #"Demo" #"finalFiguresBootscore" #"finalFiguresBootscore"
#setwd(folder)
dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")
source("RIO.R")

input <- function(inputfile) {
   parameters <<- readParameters(inputfile)
}

run <- function() {}

output <- function(outputfile) {
	pfix <- prefix()
intensityMetabolites = read.csv(paste(pfix, parameters["metabolomics", 2], sep="/"))
pathWayMap = read.csv(paste(pfix, parameters["filter", 2], sep="/"), sep="\t",header = F)
IDs = as.character(intensityMetabolites$HMDB...Representative.ID.)
names = as.character(intensityMetabolites$Metabolite)
pathWayMap$V1 = as.character(pathWayMap$V1 )
pathWayMap$V2 = as.character(pathWayMap$V2 )



map = c()
for (i in 1:(nrow(intensityMetabolites))){
  if (length(IDs[i]) == 0){
    next
  }
  index = (which(pathWayMap$V2 %in% IDs[i]))
  if (length(index) == 1){
    map = rbind(map,c(names[i],IDs[i],pathWayMap$V1[index]))
  }
}


colnames(map) = c("OriginalName","HMDB","pathWayToolsName")

write.table(map,outputfile,sep=",",quote=T, row.names = F)

}
