#commenting
library(dplyr)
library(tidyverse)
library(plotly)
library(ggplot2)
library(readr)


source("a5 ui.R")
source("a5 server.R")

#Run the application
shinyApp(ui = ui, server = server)


