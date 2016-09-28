function (input, output, session) {
  
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
        "PDF" = "pdf",
        "JPG" = "jpg",
        "SVG" = "svg",
        "PNG" = "png"
      ),
      inline = TRUE
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
}