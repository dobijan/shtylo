# load dependencies
library(stylo)
library(mongolite)
library(shiny)
library(shinyBS)

db.url <- "mongodb://localhost:27017"
wd <- normalizePath("./../../workspace")

data(novels)
pc <- parse.corpus(novels)

#initialize MongoDB connection
# server <- mongo.create()
# conn <- mongo.is.connected(server)

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