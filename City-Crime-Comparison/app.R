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

ucr_crime <- read.csv("ucr_crime_1975_2015.csv", stringsAsFactors = FALSE)
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
                  selected = 1,
                  selectize = TRUE),

      selectInput("city2Input", label = h3("City 2"),
                  choices = cities,
                  selected = 'Atlanta',
                  selectize = TRUE),

      sliderInput("yearInput2", label = h3("Year Range"), step = 5,
                  min = 1975, max = 2015, value = c(1975,2015),
                  sep = ""
      )
    ),
    mainPanel(
      tabsetPanel( id = 'tabs', selected = 'rape_sum-rape_per_100k',
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
  
  y_labels <- list('violent_crime' = 'Total Violent Crime', 'violent_per_100k' = 'Violent Crime per 100k', 
                   'homs_sum' = 'Total Homicides', 'homs_per_100k' = 'Homicides per 100k',
                   'rape_sum' = 'Total Rapes', 'rape_per_100k' = 'Rapes per 100k',
                   'rob_sum' = 'Total Robberies', 'rob_per_100k' = 'Robberies per 100k',
                   'agg_ass_sum' = 'Total Aggrevated Assualt', 'agg_ass_per_100k' = 'Aggrevated Assualt per 100k')
  
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
      geom_line(size = 1.5) +
      xlab('Year') +
      ylab(y_labels[variables()[[1]][1]]) +
      labs(colour = "City") +
      scale_color_manual(values = c('#d8b365', '#5ab4ac')) +
      theme_bw()
  )
  
  output$normalized_graph1 <- output$normalized_graph2 <- output$normalized_graph3 <- output$normalized_graph4 <- output$normalized_graph5 <-  renderPlot(
    ucr_crime_filtered() %>%
      ggplot(aes_string(x='year', y = variables()[[1]][2], group = 'department_name', color = 'department_name'))+
      geom_line(size = 1.5) +
      xlab('Year') +
      ylab(y_labels[variables()[[1]][2]]) +
      labs(colour = "City") +
      scale_color_manual(values = c('#d8b365', '#5ab4ac')) +
      theme_bw()
  )

}

# Run the application
shinyApp(ui = ui, server = server)
