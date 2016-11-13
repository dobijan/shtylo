stylo.sidebar.controller <- dget("./controllers/stylo.sidebar.controller.R")
log.controller <- dget("./controllers/log.controller.R")
url.db.controller <- dget("./controllers/url.db.controller.R")
stylo.main.controller <- dget("./controllers/stylo.main.controller.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # initialize logging
  log.service <- log.controller(input, output, session)
  
  #initialize database
  db.service <- url.db.controller(input, output, session, log.service)

  # initialize the sidebar
  stylo.params.service <- stylo.sidebar.controller(
    input, 
    output, 
    session, 
    db.service, 
    log.service
  )
    
  #initialize stylometry plots
  stylo.main.controller(
    input, 
    output, 
    session, 
    db.service, 
    log.service, 
    stylo.params.service
  )
  
})
