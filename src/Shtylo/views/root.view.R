# import the stylometry view
stylo.view <- dget("./views/stylo.view.R")

# Define the top level menu
fluidPage(
  # define a Boostrap style (found in the ./www folder)
  theme = "bootstrap.css",
  
  # create a navbar with menu items for major functions
  navbarPage(
    "Shtylo",
    tabPanel(
      "Stylometry",
      stylo.view
    ),
    tabPanel("Classification"),
    tabPanel("Rolling Delta"),
    tabPanel("Rolling Classification"),
    navbarMenu(
      "More",
      tabPanel("About Shtylo"),
      tabPanel("About Stylo")
    )
  )
)