#library
library(shiny)
library(dplyr)
library(tidyverse)
library(plotly)
library(readr)
library(ggplot2)

#values
co2_emissions_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
View(co2_emissions_data)

revised_co2_data <- co2_emissions_data %>%
  select(country, year, co2,co2_per_capita)
view(revised_co2_data)

revised_co2_data_v2 <- co2_emissions_data %>%
  select(country, year, co2,co2_per_capita,co2_growth_prct)
view(revised_co2_data_v2) 

co2percapita_data <- co2_emissions_data%>%
  select(country,year,co2_per_capita)
view(co2percapita_data )

# What are the differences in co2/co2percapita/co2 growth by country? (#1 value)
countries_by_co2 <- co2_emissions_data%>%
  select(country, year, co2, co2_per_capita)%>%
  group_by(country) %>%
  filter(country == "World")
View(countries_by_co2)

#What was the highest co2 recorded for the US in 2021?
us_co2_growth <- co2_emissions_data%>%
  select(country,co2,year)%>%
  filter(country == "United States")%>%
  filter(year == "2021")%>%
  filter(co2 == max(co2, na.rm = TRUE))%>%
  pull(co2)

# what are the highest averages of individual contribution to CO2 levels (per capita) in 15 countries, currently? (#2 value)
top_countries_co2percapita_2021 <- revised_co2_data %>%
  group_by(country) %>%
  filter(year == "2021")%>%
  arrange(desc(co2_per_capita))%>%
  head(15)

# what were the highest averages of individual contribution to CO2 levels (per capita) in 15 countries, 100 years ago? (#3 value)
top_countries_co2percapita_1921 <- co2_emissions_data %>%
  select(country, year, co2,co2_per_capita)%>%
  group_by(country) %>%
  filter(year == "1921")%>%
  arrange(desc(co2_per_capita))%>%
  head(15)


#Plot/Widget Stuff 
server <- function(input,output) {
  
  
  output$co2_chart <- renderPlotly({
    
    chart1 <- ggplot(data = countries_by_co2) +
      geom_point(mapping = aes(x= year, y= co2))+
      labs(
        x = "Year",
        y = "Co2 Emissions (in Metric Tons)",
        title = "Co2 Emissions Across the Globe"
      ) 
    chart1
  })
  
#Second Page Stuff
  output$selectCountry <- renderUI({
    selectInput("Country", "Choose a country", choices = unique(revised_co2_data$country))
    })
  
  
  scatterPlot <- reactive({
    plotData <- revised_co2_data%>%
      filter(country %in% input$Country)
    
    
    ggplot(data = plotData, aes(x= year,y= co2_per_capita)) +
      geom_point(color = input$color) +
      labs(
        x= "Year",
        y= "Co2 Emissions (Metric Tons per Capita)",
        title = "Change Over the Years in Co2 per capita",
        caption = "The graph above shows the change in individual Co2 emissions 
        over the years. It also allows users to select between various countries
        so you can see nationally Co2 differences as well.")
    })
    
    output$countryPlot <- renderPlotly({
      scatterPlot()
    })
  }