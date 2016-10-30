function (input, output, shiny.session, db.service, log.service, stylo.params.service) {
  
  # store the stylo output in a reactive variable
  session <- reactiveValues(
    stylo = NULL,
    job.status = "IDLE"
  )
  
  # the stored console output of the stylo command
  stylo.output <- vector('character')
  stylo.output.connection <- textConnection(
    object = "stylo.output",
    open = "a",
    local = TRUE
  )
  
  output$stylo.job.progress <- renderText({
    switch (
      session$job.status,
      "IDLE" = "No job scheduled...",
      "RUNNING" = "Job running...",
      "FINISHED" = "Job finished!"
    )
  })
  
  observe({
    if (input$stylo.run == 0) {
      session$job.status <- "IDLE"
    } else if (is.null(session$stylo)) {
      session$job.status <- "RUNNING"
    } else {
      session$job.status <- "FINISHED"
    }
  })
  
  # plot controller
  output$stylo.plot <- renderPlot({
    print("render plot")
    if (input$stylo.run == 0) {
      return()
    } else {
      isolate({
        session$stylo <- NULL
      })
      withProgress(
        message = "Stylometry job in progress",
        min = 0,
        max = 1,
        detail = "Loading corpus",
        session = shiny.session,
        style = "notification",
        expr = {
          corpus <- db.service$load.corpus()
          
          incProgress(
            amount = 0.2,
            detail = "Parsing corpus"
          )
          
          parsed <- parse.corpus(corpus)
              
          incProgress(
            amount = 0.2,
            detail = "Capturing Stylo console output"
          )
          
          sink(stylo.output.connection)
          
          incProgress(
            amount = 0.2,
            detail = "Invoking Stylo"
          )
          
          session$stylo <- stylo(
            
            # Invoke without GUI with predefined corpus
            gui = FALSE, 
            parsed.corpus = parsed,
            
            # Input & language
            corpus.format = input$input.select,
            encoding = ifelse(
              input$utf8.checkbox,
              "UTF-8",
              "native.enc"
            ),
            corpus.lang = input$language.select,
            
            # Features
            analyzed.features = input$features.select,
            ngram.size = input$ngram.input,
            preserve.case = input$case.checkbox,
            
            # Most Frequent Words
            mfw.min = input$mfw.minimum.input,
            mfw.max = input$mfw.maximum.input,
            mfw.incr = input$mfw.increment.input,
            start.at = input$mfw.freq.rank.input,
            
            # Culling
            culling.min = input$culling.minimum.input,
            culling.max = input$culling.maximum.input,
            culling.incr = input$culling.increment.input,
            mfw.list.cutoff = input$culling.list.cutoff.input,
            delete.pronouns = input$culling.pronoun.checkbox,
            
            #Statistics
            analysis.type = input$statistics.select,
            consensus.strength = input$statistics.consensus.input,
            text.id.on.graph = input$scatterplot.select,
            add.to.margins = input$scatterplot.margin.input,
            label.offset = input$scatterplot.offset.input,
            pca.visual.flavour = input$pca.flavour.select,
            dendrogram.layout.horizontal = input$clustering.horizontal.checkbox,
            distance.measure = input$distances.select,
            
            # Sampling
            sampling = input$sampling.select,
            sample.size = input$sampling.input,
            
            # Output
            display.on.screen = TRUE,
            write.pdf.file = TRUE,
            write.jpg.file = TRUE,
            write.png.file = TRUE,
            write.svg.file = TRUE,
            plot.options.reset = input$output.plot.default.checkbox,
            plot.custom.height = input$output.plot.height.input,
            plot.custom.width = input$output.plot.width.input,
            plot.font.size = input$output.plot.font.input,
            plot.line.thickness = input$output.plot.line.input,
            colors.on.graphs = input$output.plot.colour.choices,
            titles.on.graphs = input$output.plot.titles.checkbox,
            
            # Undocumented but useful options
            custom.graph.filename = custom.graph.file.prefix
          )
          
          incProgress(
            amount = 0.4,
            detail = "Releasing console output"
          )
          
          sink()
        }
      )
    }
  })
  
  # frequency table controller
  output$frequency.table <- renderTable({
    frequencies <- session$stylo$frequencies.0.culling
    if (is.null(session$stylo)) {
      return(NULL)
    }
    session$frequencies <- t(frequencies)
    session$frequencies
  },
  include.rownames = TRUE)
  
  # all features table controller
  output$all.features.table <- renderText({
    features <- session$stylo$features
    if (is.null(session$stylo)) {
      return(NULL)
    }
    result <- strsplit(x = features, split = " ")
    session$features <- paste(result, collapse = "\n")
    session$features
  })
  
  # used feature table controller
  output$used.features.table <- renderText({
    features <- session$stylo$features.actually.used
    if (is.null(session$stylo)) {
      return(NULL)
    }
    result <- strsplit(x = features, split = " ")
    session$features.used <- paste(result, collapse = "\n")
    session$features.used
  })
  
  # distance table controller
  output$distance.table <- renderTable({
    distances <- session$stylo$distance.table
    if (is.null(session$stylo)) {
      return(NULL)
    }
    session$distances <- distances
    session$distances
  },
  include.rownames = TRUE)
  
  # all features table download controller
  output$download.all.features <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "features.all", "txt", sep = ".")
    },
    content = function(handle) {
      writeLines(session$features, handle)
    }
  )
  
  # used features table download controller
  output$download.used.features <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "features.used", "txt", sep = ".")
    },
    content = function(handle) {
      writeLines(session$features.used, handle)
    }
  )
  
  # frequencies table download controller
  output$download.frequencies <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "frequencies", "txt", sep = ".")
    },
    content = function(handle) {
      write.csv(x = session$frequencies, file = handle, sep = ";")
    }
  )
  
  # distances table download controller
  output$download.distances <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "distances", "txt", sep = ".")
    },
    content = function(handle) {
      write.csv(x = session$distances, file = handle, sep = ";")
    }
  )
  
  # distances table download controller
  output$download.plot <- downloadHandler(
    filename = function() {
      paste(
        input$db.database, 
        input$db.collection, 
        input$output.plot.format.choices, 
        sep = "."
      )
    },
    content = function(handle) {
      file.copy(
        from = paste(
          custom.graph.file.prefix,
          "_001.",
          input$output.plot.format.choices,
          sep = ""
        ),
        to = handle,
        copy.date = FALSE,
        copy.mode = FALSE,
        recursive = FALSE,
        overwrite = FALSE
      )
    },
    contentType = switch (
      EXPR = input$output.plot.format.choices,
      "png" = "image/png",
      "svg" = "image/svg+xml",
      "jpg" = "image/jpeg",
      "pdf" = "application/pdf",
      "application/octet-stream"
    )
  )
  
  # plot file format selection controller
  observe({
    updateSelectInput(
      shiny.session, 
      "output.plot.format.choices", 
      choices = c(
        "PDF" = "pdf",
        "JPG" = "jpg",
        "SVG" = "svg",
        "PNG" = "png"
      )
    )
  })
  
  observeEvent(poll.stylo.output(), {
    entry <- poll.stylo.output()
    if (entry != "") {
      log.service$log(
        entry,
        where = "stylo"
      )
    }
  })
  
  poll.stylo.output <- reactivePoll(
    intervalMillis = 1000, 
    session = shiny.session,
    # check for change of value to be printed
    checkFunc = function() {
      if (length(stylo.output) > 0) {
        rev(stylo.output)
      } else {
        ""
      }
    },
    # This function returns the content of the log entry
    valueFunc = function() {
      if (length(stylo.output) > 0) {
        rev(stylo.output)
      } else {
        ""
      }
    }
  )
  
  # shiny.session$onSessionEnded(function() {
  #   close(stylo.output.connection)
  # })
}