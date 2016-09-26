library(shiny)
library(stylo)
library(shinyBS)

# fluidRow(
#   column(
#     12,
#     titlePanel("Shtylo"),
#     align = "center"
#   )
# ),
# titlePanel(
#   "Shtylo - a Shiny wrapper for Maciej Eder's Stylo",
#   "Shtylo"
# ),

# Sidebar with a slider input for number of bins 
# sidebarLayout(
#   sidebarPanel(
#      sliderInput("bins",
#                  "Number of bins:",
#                  min = 1,
#                  max = 50,
#                  value = 30)
#   ),
#   
#   # Show a plot of the generated distribution
#   mainPanel(
#      plotOutput("distPlot")
#   )
# )