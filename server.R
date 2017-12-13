library(shiny)
library(tidyverse)
library(leaflet)
library(rgdal)
library(htmltools)


states <- rgdal::readOGR("States.JSON.txt", "OGRGeoJSON")
state_specialty <- read.table("specialty_by_state_data.csv", header = TRUE, sep = ',')
regional_specialty <- read.table("regional_specialty_data.csv", header = TRUE, sep = ',')
States_physicians<- read.csv("specialty_by_state_data.csv")

# Define server logic required to draw a histogram
function(input, output) {
  
  output$specialty_plot <- renderPlot({
    
    # draw the barplot with the specialties as x
    gather(state_specialty, key = "specialty", value = "value", Psychiatry:Other) %>%
      filter(Location == input$state) %>%
      ggplot(aes(specialty, value)) + geom_bar(stat = 'identity', color = "slateblue3", fill = "slateblue1")+ theme(axis.text.x = element_text(angle = 60, hjust = 1), panel.background = element_rect(fill = "lavender"))
  })
  output$regional_plot <- renderPlot({
    
    #draw the barplot with specialties as x and regions as select input
    gather(regional_specialty, key = "specialty", value = "value", Psychiatry:Other) %>%
      filter(Location == input$region) %>%
      ggplot(aes(specialty, value)) + geom_bar(stat= 'identity', color = "slateblue3", fill = "slateblue1") + theme(axis.text.x = element_text(angle = 60, hjust = 1), panel.background = element_rect(fill = "lavender"))
  })
  output$population_plot <- renderPlot({
    
    #draw the barplot with the states as x
    state_specialty[-1,] %>%
      ggplot(aes_string("Location", input$specialty)) + geom_bar(stat = 'identity', color = "slateblue3", fill = "slateblue1") + theme(axis.text.x = element_text(angle = 60, hjust = 1), panel.background = element_rect(fill = "lavender"))
  })
  #################
  "Heat Map of US States with physicians per capita"
  
  output$Physician_Heatmap <-renderLeaflet({
    joinedData<-left_join(states@data, Copy_of_Per10KData1, by= c("NAME"="Location"))
    states@data <- joinedData
    pal1 <- colorNumeric(
      palette = c("cyan", "darkblue"),
      domain = states@data$CapitaRatio)
    labels1 <- sprintf(
      "<strong>%s</strong><br/>%g Physicians",
      states@data$NAME,
      states@data$CapitaRatio
    ) %>%
      lapply(htmltools::HTML)
    leaflet(data = states) %>%
      addTiles %>%
      addPolygons(fillColor = ~pal1(CapitaRatio),
                  fillOpacity = 0.8,
                  color = "black",
                  weight = 1,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "black",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE),
                  label = labels1,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal",
                                 padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      addLegend(pal = pal1, 
                values = ~CapitaRatio, 
                opacity = 0.7, 
                title = NULL,
                position = "bottomright") %>%
      setView(lat = 38.0110306, lng = -110.4080342, zoom = 3)
    
  })
}



