function (input, output, session) {
  default.label <- reactiveValues(
    default = TRUE,
    error = FALSE
  )
  
  console <- reactiveValues(
    db.log = c(),
    stylo.log = c()
  )
  
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
  
  output$db.console <- renderText({
    return(paste(console$db.log, collapse = '\n'))
  })
  
  
  output$stylo.console <- renderText({
    return(paste(console$stylo.log, collapse = '\n'))
  })
  
  export <- list(console, log, default.label)
  names(export) <- c("console", "log", "default.label")
  export
}