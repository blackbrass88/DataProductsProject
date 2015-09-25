
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
fuelData <- readRDS("fuelData.rds")

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Estimating Vehicle Fuel Economy"),
   
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
                         choices = levels(fuelData$drive),
                         selected="2-Wheel Drive",
                         inline = TRUE),
      
      selectInput(inputId = "trany",
                  label = "Transmission:",
                  choices = levels(fuelData$trany),
                  selected = "Manual 6-spd"),
      
      sliderInput(inputId = "displ",
                  label = "Engine Displacement (liters):",
                  min = 0.9,
                  max = 8.4,
                  value = 2.4,
                  step = 0.1),
      
      checkboxInput(inputId ="sCharger",
                    label = "Supercharger",
                    value = FALSE),
      
      checkboxInput(inputId = "tCharger",
                    label = "Turbocharger",
                    value = FALSE)
      
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
      p("This web application allows you to estimate a vehicle's fuel economy 
        (miles per gallon or MPG) based on engine size, number of cylinders 
        transmission type, drive type, model year, and the presence of a 
        supercharger or turbo charger.  Simply adjust the parameters on the 
        left to match your specifications.  You will see the MPG estimate below 
        automatically update.  Finally, any actual vehicles that meet these 
        parameters will display in the table."),
      p("This predictive model was built using data from fueleconomy.gov for 
        model years 1987 to 2016. Infromation on how the model was built is 
        available at the following github repository"),
      a(href="https://github.com/blackbrass88/DataProductsProject",
        "github.com/blackbrass88/DataProductsProject"),
      h3('Estimated MPG:'),
      verbatimTextOutput("mpg"),
      h3('Matching Vehicles'),
      tableOutput("cars")
  )
))
