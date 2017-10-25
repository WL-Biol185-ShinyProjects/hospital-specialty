library(shiny)
library(tidyverse)
state_specialty <- read.table("specialty_by_state_data.csv", header = TRUE, sep = ',')
gather(state_specialty, key = "specialty", value = "value", Psychiatry:Other)

# Define server logic required to draw a histogram
function(input, output) {
  
  output$specialty_plot <- renderPlot({
    
    # draw the barplot with the specialties as x
    gather(state_specialty, key = "specialty", value = "value", Psychiatry:Other)
    
  })
  
}