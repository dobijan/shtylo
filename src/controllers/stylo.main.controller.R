function (input, output, session, dbService) {
  
  output$stylo.plot <- renderPlot({
    if (input$stylo.test == 0) {
      return()
    } else {
      print(dbService)
      corpus <- dbService$load.corpus()
      print(corpus)
      parsed <- parse.corpus(corpus)
      stylo(gui = FALSE, parsed.corpus = parsed, display.on.screen = TRUE)
    }
  })
  
  
  
}