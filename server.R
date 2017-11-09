library(shiny)
library(tidyverse)
state_specialty <- read.table("specialty_by_state_data.csv", header = TRUE, sep = ',')

# Define server logic required to draw a histogram
function(input, output) {
  
  output$specialty_plot <- renderPlot({
    
    # draw the barplot with the specialties as x
    gather(state_specialty, key = "specialty", value = "value", Psychiatry:Other) %>%
      filter(Location == input$state) %>%
    ggplot(aes(specialty, value)) + geom_bar(stat = 'identity', color = "slateblue3", fill = "slateblue1")+ theme(axis.text.x = element_text(angle = 60, hjust = 1), panel.background = element_rect(fill = "lavender"))
  })
  
