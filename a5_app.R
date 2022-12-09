#library
library(dplyr)
library(tidyverse)
library(plotly)
library(ggplot2)
library(readr)

#source
source("a5_ui.R")
source("a5_server.R")

#Run the application
shinyApp(ui = ui, server = server)


