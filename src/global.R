# load dependencies
library(stylo)
library(mongolite)
library(shiny)
library(shinyBS)
library(properties)

shtylo.properties <- read.properties("./.shiny_app.conf")
writeLines("The following Shtylo properties were loaded:")
for (key in names(shtylo.properties)) {
  writeLines(
    paste(
      key,
      shtylo.properties[[key]],
      sep = "="
    )
  )
}

db.url <- shtylo.properties$db.url
wd <- normalizePath(shtylo.properties$wd, winslash = "\\")
custom.graph.file.prefix <- shtylo.properties$custom.graph.file.prefix