# define the main panel of the databasa connection view
db.main.view <- mainPanel(
  width = 12,
  tags$head(
    tags$style(
      type='text/css', 
      '#dbConsole {overflow-y:scroll; min-height: 350px; max-height: 350px;'
    )
  ),
  div(
    h5(
      "Database Log"
    ),
    verbatimTextOutput(
      "dbConsole"
    )
  ),
  HTML('<hr style="color: grey;">'),
  h2("Corpus upload"),
  uiOutput('resettable.file.input'),
  tableOutput("corpus.table"),
  # actionButton(
  #   "corpus.upload",
  #   "Upload",
  #   icon = icon(name = "upload", lib = "font-awesome")
  # )
  bsButton(
    "corpus.upload",
    "Upload",
    icon = icon(name = "upload", lib = "font-awesome")
  )
)

# define the database connection config sidebar
db.config.view <- sidebarPanel(
  width = 12,
  wellPanel(
    textInput("db.database", "Database Name", value = "", width = "100%", placeholder = "Your database..."),
    textInput("db.collection", "Collection (Corpus) Name", value = "", width = "100%", placeholder = "Your corpus..."),
    actionButton("db.connect", "Connect", icon = icon(name = "plug", lib = "font-awesome")),
    conditionalPanel(
      condition = "output['db.status'] !== 'Not Connected'",
      icon(name = "check", lib = "font-awesome")
    ),
    conditionalPanel(
      condition = "output['db.status'] === 'Not Connected'",
      icon(name = "times", lib = "font-awesome")
    ),
    textOutput("db.status", inline = TRUE)
  )
)

# defined the database connection view
fluidRow(
  column(
    4, # width out of 12
    db.config.view
  ),
  column(
    8, # width out opf 12
    db.main.view
  )
)