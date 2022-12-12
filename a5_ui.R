#library
library(shiny)
library(dplyr)
library(tidyverse)
library(plotly)
library(ggplot2)

#data
co2_emissions_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
view(co2_emissions_data)

revised_co2_data <- co2_emissions_data %>%
  select(country, year, co2,co2_per_capita)

co2percapita_data <- co2_emissions_data%>%
  select(country,year,co2_per_capita)%>%
view(co2percapita_data )

countries <- unique(revised_co2_data$country)

country_options_input <-selectInput(
  "country",
  label = "Country",
  choices = countries
)

color_options_input <- selectInput(
  "color",
  label = "Choose a color",
  choices = list("Orange","Red", "Green", "Black", "Pink")
)
  

#pages
Intro_panel <- tabPanel(
  "Introduction",
  titlePanel(strong("Introduction", align = "center")),
  hr(style = "border-top: 1px solid #000000;"),
  p(" After looking into the impact of climate change across the world
   I wanted to create an application that serves as a way to
   better visualize the changes in Co2 over the years. 
   I also wanted to better understand how I, as an individual, impact Co2 emissions. 
   So I decided to look at general co2 emission levels and compare that to 
    co2 per capita (individual contribution to Co2 emissions"),
  titlePanel("Change in General Co2 Emissions Over the Years"),
  plotlyOutput("co2_chart"),
  p("In the graph above you can clearly see how co2 emissions have steadily risen.
    This rise is evident in the numerous of changes in termperature we have seen globally.
    For several years, many continents have been recording record high temperatures. This 
    is a direct consequence of unchecked Co2 emissions.", align = "center"),
  br(),
  p(" After seeing the general growth in Co2 emissions it then made me look more 
  into co2 per capita levels, because I wanted to know how individuals across the world
  cause these numbers to grow? I also asked What are the highest averages of individual 
    contribution to CO2 levels (per capita) in 15 countries, currently? I found 
    that in the past year Qatar actually holds the highest average Co2 per capita
    - 35.6 metric tons Co2. Saudi Arabia(18.7), Australia (15.1), United States 
    (14.9), and Canada (14.3) also made it to top 15 countries that had the highest
    averages for Co2 per capita. Then, I looked into how my findings differed 
    100 years in the past. For 1921, the country that had the highest average 
    Co2 per capita was the United States of America - 12.6 metric tons Co2. In 
    the end the information I discovered made me want to analyze every country 
    and the co2 per capita levels."),
  br(),
  p(strong("To see the co2 per capita levels for each country, head over to the 
           Interactive Visualizations tab."))
)
second_page <- tabPanel(
  "Interactive Visualizations",
  titlePanel(strong("Change in Co2 Per Capita Levels", align = "center")),
  hr(style = "border-top: 1px solid #000000;"),
  
    sidebarLayout(
      sidebarPanel(
        uiOutput("selectCountry"),
        color_options_input,
      ),
  
    mainPanel(
      plotlyOutput("countryPlot"),
      p("This graph above shows the differing Co2 per capita levels across the 
        globe dating back to earliest recordings of it in the 19th century.", align = "center"),
      textOutput("sample text")
    )
)
)

ui <- navbarPage(
    "Co2 Emissions Uncovered",
    Intro_panel,
    second_page,
  )