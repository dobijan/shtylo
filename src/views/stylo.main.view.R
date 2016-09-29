# initialize the main view of the stylometry view
mainPanel(
  width = 12,
  h1("Log"),
  wellPanel(
    style = "overflow-y:scroll; max-height: 100px",
    verbatimTextOutput(
      "stylo.console"
    )
  ),
  tabsetPanel(
    "stylo.result.panel",
    tabPanel(
      "Plot",
      div(
        width = "100%",
        downloadButton(
          "download.plot",
          label = "Download"
        ),
        imageOutput(
          "stylo.plot"
        )
      )
    ),
    tabPanel(
      "Frequencies",
      div(
        width = "100%",
        downloadButton(
          "download.frequencies",
          label = "Download"
        ),
        tableOutput("frequency.table")
      )
    ),
    tabPanel(
      "Distances",
      div(
        width = "100%",
        downloadButton(
          "download.distances",
          label = "Download"
        ),
        tableOutput("distance.table")
      )
    ),
    tabPanel(
      "All Features",
      div(
        width = "100%",
        downloadButton(
          "download.all.features",
          label = "Download"
        ),
        verbatimTextOutput("all.features.table")
      )
    ),
    tabPanel(
      "Used Features",
      div(
        width = "100%",
        downloadButton(
          "download.used.features",
          label = "Download"
        ),
        verbatimTextOutput("used.features.table")
      )
    )
  )
)