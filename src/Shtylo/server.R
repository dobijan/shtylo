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
        "Plain Text" = "plain",
        "XML" = "xml",
        "XML (plays)" = "xml.drama",
        "XML (no titles)" = "xml.notitles",
        "HTML" = "html"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "language.select", 
      choices = c(
        "English" = "English",
        "English w/ contractions" = "English.contr",
        "English w/ contractions and compounds" = "English.all",
        "Latin" = "Latin",
        "Latin w/ u/v correction" = "Latin.corr",
        "Chinese, Japanese, Korean" = "CJK",
        "Other" = "Other"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "features.select", 
      choices = c(
        "Characters" = "c",
        "Words" = "w"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "statistics.select", 
      choices = c(
        "Cluster Analysis" = "CA",
        "MDS" = "MDS",
        "PCA (covariance)" = "PCV",
        "PCA (correlation)" = "PCR",
        "tSNE" = "TSNE",
        "Consensus Tree" = "BCT"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "scatterplot.select", 
      choices = c(
        "Labels" = "labels",
        "Points" = "points",
        "Both" = "both"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "pca.flavour.select", 
      choices = c(
        "Classic" = "classic",
        "Loadings" = "loadings",
        "Technical" = "technical",
        "Symbols" = "symbols"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "distances.select", 
      choices = c(
        "Classic Delta" = "dist.delta",
        "Argamon's Delta" = "dist.argamon",
        "Eder's Delta" = "dist.eder",
        "Eder's Simple Distance" = "dist.simple",
        "Manhattan" = "dist.manhattan",
        "Canberra" = "dist.canberra",
        "Euclidean" = "dist.euclidean",
        "Cosine" = "dist.cosine"
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
        "Colours" = "colors",
        "Greyscale" = "grayscale",
        "Black" = "black"
      )
    )
  })
  
  
  default.label <- reactiveValues(
    default = TRUE,
    error = FALSE
  )
  
  console <- reactiveValues(
    db.log = c()
  )
  
  status.string <- eventReactive(input$db.connect, {
    paste("Connected to", paste(input$db.database, input$db.collection, sep = ":"), sep = " ")
  })
  
  observeEvent(input$db.connect, {
    tryCatch({
        c <- mongolite::mongo(
          collection = input$db.collection,
          db = input$db.database,
          url = db.url,
          verbose = TRUE
        )
        log(
          paste(
            "Connection successful: ",
            input$db.database,
            ":",
            input$db.collection,
            sep = ""
          ),
          where = "db"
        )
        default.label$error <- FALSE
      },
      error = function(err) {
        log(
          paste(
            "Connection failed! invalid connection parameters: database='",
            input$db.database,
            "', collection='",
            input$db.collection,
            "'!",
            sep = ""
          ),
          where = "db"
        )
        default.label$error <- TRUE
      },
      finally = {
        default.label$default <- FALSE
      }
    )
  })
  
  observeEvent(input$stylo.test, {
    log("test", where = "stylo")
  })
  
  log <- function (msg, where) {
    entry <- paste(format(Sys.time(), "[%Y-%m-%d %H:%M:%S]"), msg, sep = " ")
    if (where == "db") {
      console$db.log <- c(entry, console$db.log)
    } else if (where == "stylo"){
      console$stylo.log <- c(entry,console$stylo.log)
    }
  }

  output$db.status <- renderText({
    if(default.label$default == TRUE) {
      "Not Connected"
    } else if (default.label$error == TRUE){
      "Invalid connection parameters!"
    } else {
      status.string()
    }
  })
  
  output$db.console <- renderText({
    return(paste(console$db.log, collapse = '\n'))
  })
  
  
  output$stylo.console <- renderText({
    return(paste(console$stylo.log, collapse = '\n'))
  })
  
})
