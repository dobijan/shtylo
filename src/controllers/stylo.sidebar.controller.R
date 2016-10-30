function (input, output, session, db.service, log.service) {
  
  observeEvent(
    eventExpr = input$stylo.run, 
    handlerExpr = {
      if (db.service$is.connected()) {
        tmp <- sidebar$run
        sidebar$run <- tmp + 1
        log.service$log(
          "Stylo invoked with given parameters...",
          where = "stylo"
        )
      } else {
        log.service$log(
          "Please connect to a database!",
          where = "stylo"
        )
      }
    }
  )
  
  sidebar <- reactiveValues(
    run = 0
  )
  
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
        "Polish" = "polish",
        "Hungarian" = "hungarian",
        "French" = "french",
        "Italian" = "italian",
        "Spanish" = "spanish",
        "Dutch" = "dutch",
        "German" = "german",
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
    updateSelectInput(
      session, 
      "output.plot.colour.choices", 
      choices = c(
        "Colours" = "colors",
        "Greyscale" = "greyscale",
        "Black" = "black"
      )
    )
  })
  
  export <- list(sidebar)
  names(export) <- c("params")
  export
}