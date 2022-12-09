library(shiny)
library(dplyr)
library(tidyverse)
library(plotly)
library(ggplot2)

co2_emissions_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
view(co2_emissions_data)

revised_co2_data <- co2_emissions_data %>%
  select(country, year, co2,co2_per_capita)

co2percapita_data <- co2_emissions_data%>%
  select(country,year,co2_per_capita)%>%
view(co2percapita_data )

countries <- unique(revised_co2_data$country)

country_input <-selectInput(
  "country",
  label = "Country",
  choices = countries
)

color_input <- selectInput(
  "color",
  label = "Choose a color",
  choices = list("Blue" = "blue","Red" = "red", "Purple" = "purple", "Black" = "black", "Orange" = "orange")
)
  

Intro_panel <- tabPanel(
  "Introduction",
  titlePanel(strong("Introduction", align = "center")),
  hr(style = "border-top: 1px solid #000000;"),
  p(" I created this application as a way to better visualize the changes in Co2 
    over the years. I also wanted to better understand how I, as an individual, 
    impact Co2 emissions. So I decided to look at general co2 emission levels, 
    co2 per capita (individual contribution to Co2 emissions), and the co2 growth
    percent across the world."),
  titlePanel("Change in General Co2 Emissions Over the Years"),
  plotlyOutput("chart_one"),
  p("Through my calculations I found that co2 emissions have risen over 4000 
    times globally since the 18th century.", align = "center"),
  titlePanel("Change in Co2 Growth Percents"),
  plotlyOutput("chart_two"),
  p(" While looking at the general increase in Co2 emissions throughout the past
    two centuries, it made me want to know specific growth trends. I wanted to 
    find out which countries had been growing the most in their emissions. Upon 
    searching for that answer I found that most of the top 15 countries that had 
    the highest amount of Co2 growth are developing countries. The #1 country 
    was Libya with a growth of nearly 28%. Among Libya, there was Cuba and Nicaragua.
    The growth in Co2 can probably be attributed to the fact that these 
    countries need the fuel to develop their economy and prosper."),
  br(),
  p(" After seeing the growth percents it then made me look more into co2 per capita 
    levels, asking the question - What are the highest averages of individual 
    contribution to CO2 levels (per capita) in 15 countries, currently? I found 
    that in the past year Qatar actually holds the highest average Co2 per capita
    - 35.6 metric tons Co2. Saudi Arabia(18.7), Australia(15.1), United States 
    (14.9), and Canada (14.3) also made it to top 15 countries that had the highest
    averages for Co2 per capita. Then, I looked into how my findings differed 
    100 years in the past. For 1921, the country that had the highest average 
    Co2 per capita was the United States of America - 12.6 metric tons Co2. In 
    the end the information I discovered made me want to analyze every country 
    and the co2 per capita levels."),
  br(),
  p(strong("To see my findings, head over to the Interactive Visualizations tab."))
)
second_page <- tabPanel(
  "Interactive Visualizations",
  titlePanel(strong("Change in Co2 Per Capita Levels", align = "center")),
  hr(style = "border-top: 1px solid #000000;"),
  
    sidebarLayout(
      sidebarPanel(
        uiOutput("selectCountry"),
        color_input,
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
    second_page
  )