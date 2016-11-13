# A version of the data access controller, which receives connection parameters from the URL query string
function (input, output, session, log.service) {
  
  mongodb <- reactiveValues(
    conn = NULL
  )
  
  mongodb.database <- eventReactive(session$clientData$url_search, {
    print("database update")
    parsed <- parseQueryString(
      str = session$clientData$url_search, 
      nested = FALSE
    )
    parsed[['database']]
  })
  
  mongodb.collection <- eventReactive(session$clientData$url_search, {
    print("collection update")
    parsed <- parseQueryString(
      str = session$clientData$url_search, 
      nested = FALSE
    )
    parsed[['collection']]
  })
  
  status.string <- eventReactive(c(mongodb.database(), mongodb.collection()), {
    print("status string update")
    paste("Connected to", paste(mongodb.database(), mongodb.collection(), sep = ":"), sep = " ")
  })
  
  observe({
    print("attempt connection")
    tryCatch({
      mongodb$conn <- mongolite::mongo(
        collection = mongodb.collection(),
        db = mongodb.database(),
        url = db.url,
        verbose = TRUE
      )
      set.workspace(mongodb.database(), mongodb.collection())
    },
    error = function(err) {
      print(err)
      setwd(wd)
    })
  })
  
  set.workspace <- function (db, coll) {
    dir.create(file.path(wd, db), showWarnings = FALSE)
    dir.create(file.path(paste(wd, db, sep = "/"), coll), showWarnings = FALSE)
    setwd(paste(wd, db, coll, sep = "/"))
  }
  
  load.corpus <- function () {
    print("loading corpus")
    collection <- mongodb$conn$find()
    corpus <- as.list(collection$content)
    corpus <- setNames(
      object = corpus,
      nm = collection$name
    )
    corpus
  }
  
  is.connected <- function () {
    ifelse(
      test = is.null(mongodb$conn),
      yes = FALSE,
      no = TRUE
    )
  }
  
  export <- list(load.corpus, is.connected, mongodb.database, mongodb.collection)
  names(export) <- c("load.corpus", "is.connected", "database", "collection")
  export
}