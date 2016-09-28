function (input, output, session) {
  default.label <- reactiveValues(
    default = TRUE,
    error = FALSE
  )
  
  console <- reactiveValues(
    db.log = c()
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
  
  export = list(console, log, default.label)
  names(export) <- c("console", "log", "default.label")
  export
}