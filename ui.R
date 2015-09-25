
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
fuelData <- readRDS("fuelData.rds")

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Estimating Fuel Economy"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    
      selectInput(inputId = "year",
                  label = "Model Year:",
                  choices = sort(unique(fuelData$year)),
                  selected = 2016),
      
      sliderInput(inputId = "cylinders",
                label = "Number of Cylinders:",
                min = 2,
                max = 16,
                value = 4,
                step=2),
      
      radioButtons(inputId = "drive",
                         label = NULL,
                         choices = c("2-Wheel Drive"="2-Wheel Drive",
                                        "4-Wheel Driv"="4-Wheel Drive"),
                         selected="2-Wheel Drive",
                         inline = TRUE)   
      
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
   h3('Hello')
  )
))
