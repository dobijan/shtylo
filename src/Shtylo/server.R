#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   
  # output$distPlot <- renderPlot({
  #   
  #   # generate bins based on input$bins from ui.R
  #   x    <- faithful[, 2] 
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #   
  #   # draw the histogram with the specified number of bins
  #   hist(x, breaks = bins, col = 'darkgray', border = 'white')
  #   
  # })
  
  observe({
    updateSelectInput(
      session, 
      "input.select", 
      choices = c(
        "plain text",
        "xml",
        "xml (plays)",
        "xml (no titles)",
        "html"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "language.select", 
      choices = c(
        "english",
        "hungarian",
        "polish",
        "latin",
        "spanish"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "features.select", 
      choices = c(
        "characters",
        "words"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "statistics.select", 
      choices = c(
        "Cluster Analysis" = "cluster",
        "MDS" = "mds",
        "PCA (covariance)" = "pca.cov",
        "PCA (correlation)" = "pca.corr",
        "tSNE" = "tsne",
        "Consensus Tree" = "consensus.tree"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "distances.select", 
      choices = c(
        "Classic Delta",
        "Argamon's Delta",
        "Eder's Delta",
        "Eder's Simple Distance",
        "Manhattan",
        "Canberra",
        "Euclidean",
        "Cosine"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "sampling.select", 
      choices = c(
        "No Sampling" = "no.sampling",
        "Normal Sampling" = "normal.sampling",
        "Random Sampling" = "random.sampling"
      )
    )
  })
  
  observe({
    updateCheckboxGroupInput(
      session, 
      "output.graph.choices", 
      choices = c(
        "Onscreen" = "onscreen",
        "PDF" = "pdf",
        "JPG" = "jpg",
        "SVG" = "svg",
        "PNG" = "png"
      ),
      inline = TRUE,
      selected = c("onscreen")
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "output.plot.colour.choices", 
      choices = c(
        "Colours" = "colours",
        "Greyscale" = "greyscale",
        "Black" = "black"
      )
    )
  })
  
})
