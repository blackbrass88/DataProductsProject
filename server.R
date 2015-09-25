
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(caret)
library(dplyr)
model <- readRDS("modelGLM.rds")
fuelData <- readRDS("fuelData.rds")

shinyServer(function(input, output) {
   
  output$mpg <- renderPrint({
      userInputs <- data.frame(cylinders=input$cylinders,
                           displ=input$displ,
                           drive=input$drive,
                           trany=input$trany,
                           year=as.numeric(input$year),
                           sCharger=input$sCharger,
                           tCharger=input$tCharger)
      predict(model,userInputs)
  })
  
  output$cars <- renderTable({
      carModels <- filter(fuelData,cylinders==input$cylinders,
                          displ==input$displ,
                          drive==input$drive,
                          trany==input$trany,
                          year==as.numeric(input$year),
                          sCharger==input$sCharger,
                          tCharger==input$tCharger)
      select(carModels,Make=make,Model=model,MPG=comb08)
  })
  

  })

