
style <- "default"

input.language.panel <- wellPanel(
  selectInput(
    "input.select", 
    "Input", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  selectInput(
    "language.select", 
    "Language", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  checkboxInput(
    "utf8.checkbox", 
    "UTF-8", 
    value = TRUE, 
    width = NULL
  )
)

features.panel <- wellPanel(
  selectInput(
    "features.select", 
    "Features", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  numericInput(
    "ngram.input", 
    "Ngram size", 
    value = 1, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  checkboxInput(
    "case.checkbox", 
    "Preserve Case", 
    value = FALSE, 
    width = NULL
  )
)

mfw.panel <- wellPanel(
  numericInput(
    "mfw.minimum.input", 
    "Minimum", 
    value = 100, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "mfw.maximum.input", 
    "Maximum", 
    value = 100, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "mfw.increment.input", 
    "Increment", 
    value = 100, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "mfw.freq.rank.input", 
    "Starting frequency rank", 
    value = 1, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  )
)

culling.panel <- wellPanel(
  numericInput(
    "culling.minimum.input", 
    "Minimum", 
    value = 0, 
    min = 0, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "culling.maximum.input", 
    "Maximum", 
    value = 0, 
    min = 0, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "culling.increment.input", 
    "Increment", 
    value = 20, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "culling.list.cutoff.input", 
    "List cutoff", 
    value = 5000, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  checkboxInput(
    "culling.pronoun.checkbox", 
    "Delete pronouns", 
    value = FALSE, 
    width = NULL
  )
)

statistics.panel <- wellPanel(
  selectInput(
    "statistics.select", 
    "Statistics", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  conditionalPanel(
    condition = "input['statistics.select'] === 'BCT'",
    numericInput(
      "statistics.consensus.input", 
      "Consensus Strength", 
      value = 0.5, 
      min = 0.4, 
      max = 1, 
      step = 0.1, 
      width = NULL
    ),
    HTML('<hr style="color: grey;">')
  ),
  conditionalPanel(
    condition = "['MDS', 'PCV', 'PCR'].indexOf(input['statistics.select']) !== -1",
    HTML('<hr style="color: grey;">'),
    selectInput(
      "scatterplot.select", 
      "Texts on plot", 
      selected = NULL, 
      multiple = FALSE, 
      choices = NULL, 
      width = "100%"
    ),
    numericInput(
      "scatterplot.margin.input", 
      "Margins", 
      value = 2, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    numericInput(
      "scatterplot.offset.input", 
      "Label offset", 
      value = 3, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    HTML('<hr style="color: grey;">')
  ),
  conditionalPanel(
    condition = "['PCV', 'PCR'].indexOf(input['statistics.select']) !== -1",
    HTML('<hr style="color: grey;">'),
    selectInput(
      "pca.flavour.select", 
      "PCA flavour", 
      selected = NULL, 
      multiple = FALSE, 
      choices = NULL, 
      width = "100%"
    ),
    HTML('<hr style="color: grey;">')
  ),
  conditionalPanel(
    condition = "input['statistics.select'] === 'CA'",
    HTML('<hr style="color: grey;">'),
    checkboxInput(
      "clustering.horizontal.checkbox", 
      "Horizontal CA tree", 
      value = TRUE, 
      width = NULL
    ),
    HTML('<hr style="color: grey;">')
  ),
  selectInput(
    "distances.select", 
    "Distances", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  )
)

sampling.panel <- wellPanel(
  selectInput(
    "sampling.select", 
    "Sampling Method", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  conditionalPanel(
    condition = "input['sampling.select'] === 'normal.sampling'",
    numericInput(
      "sampling.input", 
      "Sample Size", 
      value = 10000, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    )
  ),
  conditionalPanel(
    condition = "input['sampling.select'] === 'random.sampling'",
    numericInput(
      "sampling.input", 
      "Random Samples", 
      value = 10000, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    )
  )
)

output.panel <- wellPanel(
    numericInput(
      "output.plot.height.input", 
      "Plot Height", 
      value = 10, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    numericInput(
      "output.plot.width.input", 
      "Plot Width", 
      value = 10, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    numericInput(
      "output.plot.font.input", 
      "Font Size", 
      value = 10, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    numericInput(
      "output.plot.line.input", 
      "Line Width", 
      value = 1, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    selectInput(
      "output.plot.colour.choices", 
      "Plot Colours", 
      choices = NULL, 
      selected = NULL, 
      multiple = FALSE, 
      width = NULL
    ),
    checkboxInput(
      "output.plot.default.checkbox", 
      "Set defaults", 
      value = FALSE, 
      width = NULL
    ),
    checkboxInput(
      "output.plot.titles.checkbox", 
      "Display titles", 
      value = FALSE, 
      width = NULL
    )
)

# create the stylometry sidebar
sidebarPanel(
  width = 12,
  bsCollapse(
    id = "stylo.sidebar",
    open = "Input & Language",
    bsCollapsePanel(
      title = "Input & Language",
      style = style,
      input.language.panel
    ),
    bsCollapsePanel(
      title = "Features",
      style = style,
      features.panel
    ),
    bsCollapsePanel(
      title = "Most Frequent Words",
      style = style,
      mfw.panel
    ),
    bsCollapsePanel(
      title = "Culling",
      style = style,
      culling.panel
    ),
    bsCollapsePanel(
      title = "Statistics",
      style = style,
      statistics.panel
    ),
    bsCollapsePanel(
      title = "Sampling",
      style = style,
      sampling.panel
    ),
    bsCollapsePanel(
      title = "Output",
      style = style,
      output.panel
    )
  ),
  actionButton(
    "stylo.run",
    label = "Run Stylo"
  )
)