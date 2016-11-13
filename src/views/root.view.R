# import the stylometry view
stylo.view <- dget("./views/stylo.view.R")

# Define the top level menu
fluidPage(
  # define a Boostrap style (found in the ./www folder)
  theme = "bootstrap.css",
  
  # create a navbar with menu items for major functions
  navbarPage(
    title = "Shtylo",
    id = "root.page",
    tabPanel(
      title = "Stylometry",
      value = "stylometry",
      icon = icon(name = "paint-brush", lib = "font-awesome"),
      stylo.view
    ),
    tabPanel(
      title = "Classification",
      value = "classification",
      icon = icon(name = "sitemap", lib = "font-awesome")
    ),
    tabPanel(
      title = "Rolling Delta",
      value = "rolling-delta",
      icon = icon(name = "line-chart", lib = "font-awesome")
    ),
    tabPanel(
      title = "Rolling Classification",
      value = "rolling-classification",
      icon = icon(name = "sort-amount-asc", lib = "font-awesome")
    ),
    navbarMenu(
      title = "More",
      icon = icon(name = "info", lib = "font-awesome"),
      tabPanel(
        title = "About Shtylo",
        value = "about-shtylo",
        icon = icon(name = "html5", lib = "font-awesome")
      ),
      tabPanel(
        title = "About Stylo",
        value = "about-stylo",
        icon = icon(name = "paint-brush", lib = "font-awesome")
      )
    )
  )
)