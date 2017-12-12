library(shiny)
library(shinydashboard)
library(leaflet)
library(rgdal)

#Load States.JSON
states <- rgdal::readOGR("States.JSON.txt", "OGRGeoJSON")

#Load Data Table
state_specialty <- read.table("specialty_by_state_data.csv", header = TRUE, sep = ',')
regional_specialty <- read.table("regional_specialty_data.csv", header = TRUE, sep = ',')

#Define UI for application that hosts all fluidpages
dashboardPage(
  dashboardHeader(title = "Physician Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Physician Specialty by State", tabName = "specialty", icon = icon("stethoscope")),
      menuItem("Physician Specialty Population", tabName = "population", icon = icon("medkit")),
      menuItem("Physicians per Capita", tabName = "capitaLeaflet", icon = icon("map-pin")),
      menuItem("References", tabName = "references", icon = icon("book"))
    ) ), 
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "home",
              #Define UI for Home Description
              fluidRow(
                box(width = 12, img(src = "MedicalCare.jpg", align = "center")),
                
                box(width = 12, p("Welcome to our web app! We analyzed data regarding the
                                  prevalence of different specialties of physicians in all
                                  50 states and District of Columbia of the United States."),
                                p(),
                                p("According to a 2016 census, the number of physicians in 
                                  the United States saw a net-increase of 12% since 2010.
                                  However, The New York Times also reported in 2016 that
                                  the apparent growth in physicians does not compare to
                                  currentl population growth trends. Therefore, the ratio
                                  of physicians per capita in the United States is only 
                                  predicted to decrease further."),
                                p(),
                                p("Given these recent trends, we believe it is important
                                  to analyze the current availability of access to physicians
                                  of different specialties across the United States to better
                                  inform individuals that might need care.")
                )
                )
              ),
      tabItem(tabName = "specialty",
              
              # Define UI for application that draws a histogram
              fluidPage(
                
                # Application title
                titlePanel("Physician Specialty by State"),
                
                # Sidebar with a input for selection of states
                sidebarLayout(
                  sidebarPanel(
                    selectInput( inputId = 'state',
                                 label = 'Select a State',
                                 state_specialty$Location,
                                 selected = "United States",
                                 multiple = FALSE,
                                 selectize = FALSE,
                                 width = NULL,
                                 size = NULL)
                  ),
                  
                  # Show a plot of the generated distribution
                  mainPanel(
                    plotOutput("specialty_plot")
                  )
                  ),
                sidebarLayout(
                  sidebarPanel(
                    selectInput(inputId = 'region',
                                label = 'Select a Region',
                                regional_specialty$Location,
                                selected = "New England",
                                multiple = FALSE,
                                selectize = FALSE,
                                width = NULL,
                                size = NULL)
                  ),
                  #Show a plot of the generated distribution
                  mainPanel(
                    plotOutput("regional_plot")
                  )
                )
                )
              ),
      tabItem(tabName = "population"),
      tabItem(tabName = "capitaLeaflet"),
      tabItem(tabName = "references",
              #Define UI for Resources List Page
              fluidRow(
                box(width = 12, img(src = "MedicalCare.jpg", align = "center")),
                
                box(width = 12,
                    a(href = "https://www.kff.org/other/state-indicator/physicians-by-specialty-area/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D", "Specialty By State Data"),
                    p(),
                    a(href = "http://www.enchantedlearning.com/usa/states/population.shtml", "State Populations"),
                    p(),
                    a(href = "http://www.ipl.org/div/stateknow/popchart.html", "State Size"),
                    p(),
                    a(href = "https://www.nytimes.com/2016/11/08/upshot/a-doctor-shortage-lets-take-a-closer-look.html", "The New York Times"),
                    p(),
                    a(href = "https://www.fsmb.org/Media/Default/PDF/Census/2016census.pdf", "2016 Census")
              ))
      )
    )
  )
)