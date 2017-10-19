# initialize the main view of the stylometry page
mainPanel(
  width = 12,
  tags$head(
    tags$style(
      type='text/css',
      '#styloConsole {overflow-y:scroll; min-height: 200px; max-height: 200px;'
    )
  ),
  div(
    h5(
      "Stylometry Log"
    ),
    verbatimTextOutput(
      "styloConsole" # CSS doesn't like dotted names :(
    )
  ),
  tabsetPanel(
    type = "tabs",
    id = "stylo.result.panel",
    tabPanel(
      "Plot",
      div(
        width = "100%",
        conditionalPanel(
          condition = "input['stylo.run'] !== 0",
          selectInput(
            "output.plot.format.choices",
            "Plot file formats",
            choices = NULL,
            selected = NULL,
            multiple = FALSE,
            width = NULL
          ),
          downloadLink(
            "download.plot",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          imageOutput(
            "stylo.plot"
          )
        )
      )
    ),
    tabPanel(
      "Frequencies",
      div(
        width = "100%",
        conditionalPanel(
          condition = "input['stylo.run'] !== 0",
          downloadLink(
            "download.frequencies",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          tableOutput("frequency.table")
        )
      )
    ),
    tabPanel(
      "Distances",
      div(
        width = "100%",
        conditionalPanel(
          condition = "input['stylo.run'] !== 0",
          downloadLink(
            "download.distances",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          tableOutput("distance.table")
        )
      )
    ),
    tabPanel(
      "All Features",
      div(
        width = "100%",
        conditionalPanel(
          condition = "input['stylo.run'] !== 0",
          downloadLink(
            "download.all.features",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          verbatimTextOutput("all.features.table")
        )
      )
    ),
    tabPanel(
      "Used Features",
      div(
        width = "100%",
        conditionalPanel(
          condition = "input['stylo.run'] !== 0",
          downloadLink(
            "download.used.features",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          verbatimTextOutput("used.features.table")
        )
      )
    )
  )
)