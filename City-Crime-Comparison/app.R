#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

ucr_crime <- read.csv("../data/ucr_crime_1975_2015.csv", stringsAsFactors = FALSE)
cities <- as.list(unique(ucr_crime$department_name))

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Crime Rate Analyzer", 
             windowTitle = "US Cities Violent Crime"
             
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput("city1Input", label = h3("City 1"), 
                  choices = cities, 
                  selected = 1),
      selectInput("city2Input", label = h3("City 2"), 
                  choices = cities, 
                  selected = 1),
      dateRangeInput("yearInput", label = h3("Year Range"), format = "yyyy",
                     startview = "decade",
                     max = "2015-12-12", min = "1975-01-01", start = "1990", end = "1990"
      ),
      sliderInput("yearInput2", label = h3("Year Range"), step = 5,
                  min = 1975, max = 2015, value = c(1980,2000),
                  sep = ""
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Total", value = "violent_crime", plotOutput("raw_graph"), plotOutput("normalized_graph")),
        tabPanel("Homicide", plotOutput(""), plotOutput("")),
        tabPanel("Rape", plotOutput(""), plotOutput("")),
        tabPanel("Robbery", plotOutput(""), plotOutput("")),
        tabPanel("Aggravated Assualt", plotOutput(""), plotOutput("")),
        id = "main_tab"
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  ucr_crime_filtered <- reactive(
    ucr_crime %>% 
        filter(between(year, input$yearInput2[1], input$yearInput2[2]),
               department_name == input$city1Input[1] | department_name == input$city2Input[1])
  )
  
  observe(print(input$main_tab))
  
  output$raw_graph = renderPlot(
    ucr_crime_filtered () %>% 
      ggplot(aes(x=year, y = violent_crime, group = department_name, color = department_name))+
        geom_line()
  )
  output$normalized_graph = renderPlot(
    ucr_crime_filtered () %>% 
      ggplot(aes(x=year, y = violent_per_100k, group = department_name, color = department_name))+
        geom_line()
  )
}

# Run the application 
shinyApp(ui = ui, server = server)