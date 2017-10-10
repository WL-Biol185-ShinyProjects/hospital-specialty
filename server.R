library(shiny)
library(tidyverse)
state_specialty <- read.table("specialty_by_state_data.csv", header = TRUE, sep = ',')

# Define server logic required to draw a histogram
function(input, output) {
  
  output$distPlot <- renderPlot({
    
    # draw the barplot with the specialties as x
    ggplot("state_specialty", aes())
    
  })
  
}