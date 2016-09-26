# import the root view
root.view <- dget("./views/root.view.R")

# initialize the Shiny app
shinyUI(
  root.view
)