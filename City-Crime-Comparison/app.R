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
                  selected = 'Atlanta'),
      
      sliderInput("yearInput2", label = h3("Year Range"), step = 5,
                  min = 1975, max = 2015, value = c(1980,2000),
                  sep = ""
      )
    ),
    mainPanel(
      tabsetPanel( id = 'tabs', selected = 'homs_sum-homs_per_100k',
        tabPanel("Total", value = 'violent_crime-violent_per_100k', plotOutput("raw_graph1"), plotOutput("normalized_graph1")),
        tabPanel("Homicide", value = 'homs_sum-homs_per_100k', plotOutput("raw_graph2"), plotOutput("normalized_graph2")),
        tabPanel("Rape",value = 'rape_sum-rape_per_100k', plotOutput("raw_graph3"), plotOutput("normalized_graph3")),
        tabPanel("Robbery", value = 'rob_sum-rob_per_100k', plotOutput("raw_graph4"), plotOutput("normalized_graph4")),
        tabPanel("Aggravated Assualt", value = 'agg_ass_sum-agg_ass_per_100k', plotOutput("raw_graph5"), plotOutput("normalized_graph5"))
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  observe(print(eval(variables()[[1]][2])))
  variables <- reactive(
    str_split(input$tabs, '-')
  )
  
  ucr_crime_filtered <- reactive(
    ucr_crime %>% 
        filter(between(year, input$yearInput2[1], input$yearInput2[2]),
               department_name == input$city1Input[1] | department_name == input$city2Input[1])
  )
  output$raw_graph1 <- output$raw_graph2 <- output$raw_graph3 <- output$raw_graph4 <- output$raw_graph5 <- renderPlot(
      ucr_crime_filtered() %>% 
      ggplot(aes_string(x='year', y = variables()[[1]][1], group = 'department_name', color = 'department_name'))+
      geom_line() +
      xlab('Year') +
      ylab(variables()[[1]][1])
  )
  output$normalized_graph1 <- output$normalized_graph2 <- output$normalized_graph3 <- output$normalized_graph4 <- output$normalized_graph5 <-  renderPlot(
    ucr_crime_filtered() %>% 
      ggplot(aes_string(x='year', y = variables()[[1]][2], group = 'department_name', color = 'department_name'))+
      geom_line() +
      xlab('Year') +
      ylab(variables()[[1]][2])
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)