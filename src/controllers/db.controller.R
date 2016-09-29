function (input, output, session, logService) {
  
  mongodb <- reactiveValues(
    conn = NULL
  )
  
  set.workspace <- function (db, coll) {
    dir.create(file.path(wd, db), showWarnings = FALSE)
    dir.create(file.path(paste(wd, db, sep = "/"), coll), showWarnings = FALSE)
    setwd(paste(wd, db, coll, sep = "/"))
  }
  
  status.string <- eventReactive(input$db.connect, {
    paste("Connected to", paste(input$db.database, input$db.collection, sep = ":"), sep = " ")
  })
  
  observeEvent(input$db.connect, {
    tryCatch({
      mongodb$conn <- mongolite::mongo(
        collection = input$db.collection,
        db = input$db.database,
        url = db.url,
        verbose = TRUE
      )
      logService$log(
        paste(
          "Connection successful: ",
          input$db.database,
          ":",
          input$db.collection,
          sep = ""
        ),
        where = "db"
      )
      logService$default.label$error <- FALSE
      set.workspace(input$db.database, input$db.collection)
    },
    error = function(err) {
      logService$log(
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
      logService$default.label$error <- TRUE
      setwd(wd)
    },
    finally = {
      logService$default.label$default <- FALSE
    }
    )
  })
  
  observeEvent(input$corpus.upload, {
    if (is.null(files$files) || is.null(mongodb$conn)) {
      logService$log("Please connect to a database and select some files for upload!", where = "db")
      return()
    }
    tryCatch({
      texts <- files$files
      content <- sapply(texts$datapath, function (path) {
        paste(readLines(path), collapse = "\n")
      }, simplify = TRUE)
      texts$content <- content
      texts$datapath <- NULL
      mongodb$conn$insert(texts)
      logService$log(
        paste(
          "Corpus insertion successful: ",
          input$db.database,
          ":",
          input$db.collection,
          sep = ""
        ),
        where = "db"
      )
    },
    error = function(err) {
      logService$log(
        paste(
          "Corpus insertion failed at: ",
          input$db.database,
          ":",
          input$db.collection,
          ", error: ",
          err,
          sep = ""
        ),
        where = "db"
      )
    })
  })
  
  output$db.status <- renderText({
    if(logService$default.label$default == TRUE) {
      "Not Connected"
    } else if (logService$default.label$error == TRUE){
      "Invalid connection parameters!"
    } else {
      status.string()
    }
  })
  
  output$corpus.table <- renderTable({
    texts <- files$files
    if (is.null(texts)) {
      return(NULL)
    }
    texts$datapath <- NULL
    names(texts) <- c("File names", "File sizes (Bytes)", "MIME Type")
    texts
  })
  
  files <- reactiveValues(
    files = NULL
  )
  
  observe({
    input$corpus.upload
    files$files <- NULL
  })
  
  
  observe({
    files$files <- input$corpus.selector
  })
  
  output$resettable.file.input <- renderUI({
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
  
  
  load.corpus <- function () {
    collection <- mongodb$conn$find()
    corpus <- as.list(collection$content)
    corpus <- setNames(
      object = corpus,
      nm = collection$name
    )
    corpus
  }
  
  export <- list(load.corpus)
  names(export) <- c("load.corpus")
  export
}