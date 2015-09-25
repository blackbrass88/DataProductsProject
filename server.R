
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(caret)
model <- readRDS("modelGLM.rds")
fuelData <- readRDS("fuelData.rds")

shinyServer(function(input, output) {
   
  
    
  })
  
})
