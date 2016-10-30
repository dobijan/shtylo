# load dependencies
library(stylo)
library(mongolite)
library(shiny)
library(shinyBS)

db.url <- "mongodb://localhost:27017"
wd <- normalizePath("./../../workspace", winslash = "\\")
custom.graph.file.prefix <- "graph"