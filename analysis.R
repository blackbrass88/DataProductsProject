require(dplyr)
require(caret)
require(ggplot2)

if(!file.exists("vehicles.csv")) {
    if(!file.exists("vehicles.csv.zip")) {
        download.file("https://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip"
                      ,"vehicles.csv.zip")
    }
    unzip("vehicles.csv.zip")
}

fueleconomy.govData <- read.csv("vehicles.csv")

# Blank atvType indicated traditional gasoline vehicles
# Remove older models to eliminate empty data fields
fuelData <- filter(fueleconomy.govData, atvType=="", year>=1987) %>% 
    select(comb08, cylinders, displ, drive, trany, year, sCharger, tCharger,
           make, model)

# Input missing Data
fuelData$drive[fuelData$year==2002 & fuelData$make=="Lotus"] <- "Rear-Wheel Drive"

# Merge 4 & All Wheel Drives
fuelData$drive[grep("4-Wheel | *All-Wheel",fuelData$drive)] <- "4-Wheel Drive"
# Merge to 2-Wheel drive
fuelData$drive[grep("*Front-Wheel | *Rear-Wheel",fuelData$drive)] <- "2-Wheel Drive"
fuelData$drive <- droplevels(fuelData$drive)

fuelData$sCharger <- as.character(fuelData$sCharger)
fuelData$sCharger[fuelData$sCharger=="S"] <- "TRUE"
fuelData$sCharger[fuelData$sCharger==""] <- "FALSE"
fuelData$sCharger <- as.logical(fuelData$sCharger)

fuelData$tCharger[is.na(fuelData$tCharger)] <- FALSE

modelData <- select(fuelData, -make, -model)

inTrain <- createDataPartition(y=modelData$comb08,p=0.8,list=F)
training <- modelData[inTrain,]
testing <- modelData[-inTrain,]

modelGLM <- train(comb08 ~ .,data=training,method="glm")
testResults <- data.frame(actual=testing$comb08,modelGLM=predict(modelGLM,testing))
saveRDS(modelGLM,"modelGLM.rds")
saveRDS(fuelData, "fuelData.rds")
