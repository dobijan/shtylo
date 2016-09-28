stylo.sidebar.controller <- dget("./controllers/stylo.sidebar.controller.R")
log.controller <- dget("./controllers/log.controller.R")
db.controller <- dget("./controllers/db.controller.R")
stylo.main.controller <- dget("./controllers/stylo.main.controller.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # initialize the sidebar
  stylo.sidebar.controller(input, output, session)
  
  # initialize logging
  logService <- log.controller(input, output, session)
  
  #initialize database
  dbService <- db.controller(input, output, session, logService)
  
  #initialize stylometry plots
  stylo.main.controller(input, output, session, dbService)
  
})
