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
  h1("Plot Area"),
  div(
    width = "100%",
    imageOutput(
      "stylo.plot"
    )
  )
)