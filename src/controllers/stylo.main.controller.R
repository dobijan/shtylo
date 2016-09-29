function (input, output, session, dbService) {
  
  session <- reactiveValues(
    stylo = NULL
  )
  
  output$stylo.plot <- renderPlot({
    if (input$stylo.test == 0) {
      return()
    } else {
      print(dbService)
      corpus <- dbService$load.corpus()
      print(corpus)
      parsed <- parse.corpus(corpus)
      session$stylo <- stylo(gui = FALSE, parsed.corpus = parsed, display.on.screen = TRUE)
    }
  })
  
  output$frequency.table <- renderTable({
    frequencies <- session$stylo$frequencies.0.culling
    if (is.null(session$stylo)) {
      return(NULL)
    }
    t(frequencies)
  })
  
  output$all.features.table <- renderText({
    features <- session$stylo$features
    if (is.null(session$stylo)) {
      return(NULL)
    }
    result <- strsplit(x = features, split = " ")
    session$features <- paste(result, collapse = "\n")
    session$features
  })
  
  output$used.features.table <- renderText({
    features <- session$stylo$features.actually.used
    if (is.null(session$stylo)) {
      return(NULL)
    }
    result <- strsplit(x = features, split = " ")
    paste(result, collapse = "\n")
  })
  
  output$distance.table <- renderTable({
    distances <- session$stylo$distance.table
    if (is.null(session$stylo)) {
      return(NULL)
    }
    distances
  })
  
  output$download.all.features <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "txt", sep = ".")
    },
    content = function(file) {
      session$features
    }
  )
  
}