# define the main panel of the databasa connection view
db.main.view <- mainPanel(
  width = 12,
  h2(
    "Event Log"
  ),
  wellPanel(
    style = "overflow-y:scroll; max-height: 400px",
    verbatimTextOutput(
      "db.console"
    )
  ),
  HTML('<hr style="color: grey;">'),
  h2("Corpus upload"),
  # fileInput(
  #   "corpus.selector",
  #   "Select texts to upload",
  #   multiple = TRUE,
  #   accept = c(
  #     "application/xml",
  #     "text/xml",
  #     "text/html",
  #     "text/plain"
  #   ),
  #   width = "100%"
  # ),
  uiOutput('resettableInput'),
  tableOutput("corpus.table"),
  actionButton(
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