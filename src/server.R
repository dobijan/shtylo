stylo.sidebar.controller <- dget("./controllers/stylo.sidebar.controller.R")
log.controller <- dget("./controllers/log.controller.R")
db.controller <- dget("./controllers/db.controller.R")

set.workspace <- function (db, coll) {
  dir.create(file.path(wd, db), showWarnings = FALSE)
  dir.create(file.path(paste(wd, db, sep = "/"), coll), showWarnings = FALSE)
  setwd(paste(wd, db, coll, sep = "/"))
}

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # initialize the sidebar
  stylo.sidebar.controller(input, output, session)
  
  # initialize logging
  logService <- log.controller(input, output, session)
  
  #initialize database
  db.controller(input, output, session, logService)
  
  
  output$db.console <- renderText({
    return(paste(logService$console$db.log, collapse = '\n'))
  })
  
  
  output$stylo.console <- renderText({
    return(paste(logService$console$stylo.log, collapse = '\n'))
  })
  
  output$stylo.plot <- renderPlot({
    if (input$stylo.test == 0) {
      return()
    } else {
      stylo(gui = FALSE, parsed.corpus = pc, display.on.screen = TRUE)
    }
  })
  
  output$resettableInput <- renderUI({
    input$corpus.upload
    fileInput(
      "corpus.selector",
      "Select texts to upload",
      multiple = TRUE,
      accept = c(
        "application/xml",
        "text/xml",
        "text/html",
        "text/plain"
      ),
      width = "100%"
    )
  })
  
})
